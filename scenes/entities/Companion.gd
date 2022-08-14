extends Entity

export var vision_range = 300
export var max_distance_to_player = 100
export var player_path: NodePath
export var weapon_path: NodePath

var player: Player
var enemies: Array


func _ready() -> void:
	player = get_node(player_path)
	current_weapon = get_node(weapon_path)
	enemies = get_tree().get_nodes_in_group("Enemies")


func _physics_process(_delta: float) -> void:	
	var companion_to_player = player.position - position
	var distance_to_player = companion_to_player.abs().length()
	
	if distance_to_player <= vision_range and distance_to_player > max_distance_to_player:
		velocity = companion_to_player.normalized() * speed
		velocity = move_and_slide(velocity)
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$AnimatedSprite.animation = "right"
			else:
				$AnimatedSprite.animation = "left"
		else:
			if velocity.y > 0:
				$AnimatedSprite.animation = "down"
			else:
				$AnimatedSprite.animation = "up"
	else:
		$AnimatedSprite.animation = "default"
	
	if !$Footsteps.playing && $AnimatedSprite.animation != 'default':
		$Footsteps.play()

func get_nearest_enemy() -> Node2D:
	var nearest_distance = INF
	var nearest_enemy = null
	
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		var distance = global_position.distance_squared_to(enemy.global_position)
		if distance < nearest_distance:
			nearest_enemy = enemy
			nearest_distance = distance
	
	return nearest_enemy


func is_enemy_visible(enemy: Node2D) -> bool:
	if global_position.distance_to(enemy.global_position) > vision_range:
		return false
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, enemy.global_position)

	return true if result else false


func _on_Timer_timeout() -> void:
	var nearest_enemy = get_nearest_enemy()
	
	if nearest_enemy and is_enemy_visible(nearest_enemy):
		current_weapon.look_at(nearest_enemy.global_position)
		current_weapon.rotate(PI / 2)
		current_weapon.shoot()
