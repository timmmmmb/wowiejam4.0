extends Entity
class_name base_enemy
export (NodePath) var weapon
enum STATE {IDLE, PATROLLING, ATTACKING, DEAD, SEARCHING}
var state = STATE.IDLE
export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0
export var attack_delay = 1.0
export var vision_range = 300
var enemies: Array

func _ready() -> void:
	$AttackDelay.wait_time = attack_delay
	current_weapon = get_node(weapon)
	enemies = get_tree().get_nodes_in_group("Player")
	wake_up()

func wake_up():
	state = STATE.PATROLLING
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$AttackDelay.start(rng.randf_range(0,2)+attack_delay)
	$AnimatedSprite.play()
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(_delta):
	behaviour()

func is_enemy_visible(enemy: Node2D) -> bool:
	if global_position.distance_to(enemy.global_position) > vision_range:
		return false
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, enemy.global_position)

	return true if result else false

func get_nearest_enemy() -> Node2D:
	var nearest_distance = INF
	var nearest_enemy = null
	
	for enemy in enemies:
		var distance = global_position.distance_squared_to(enemy.global_position)
		if  distance < nearest_distance:
			nearest_enemy = enemy
			nearest_distance = distance
	
	return nearest_enemy
	
func shoot() -> void:
	var target = get_nearest_enemy().position
	current_weapon.look_at(target)
	current_weapon.rotate(PI / 2)
	current_weapon.shoot()
	
func move(target) -> void:
	velocity = (target - position).normalized() * speed
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
	if !$Footsteps.playing:
		$Footsteps.play()


func behaviour():
	if state == STATE.DEAD:
		return
	var seesEnemy = is_enemy_visible(get_nearest_enemy())
	if seesEnemy:
		state = STATE.ATTACKING
		$AnimatedSprite.animation = "default"
	elif !seesEnemy && state == STATE.ATTACKING:
		state = STATE.SEARCHING
		$SearchTimer.start()
	if patrol_path && state == STATE.PATROLLING:
		var target = patrol_points[patrol_index]
		if position.distance_to(target) < 1:
			patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
			target = patrol_points[patrol_index]
		move(target)
	elif state == STATE.ATTACKING && $AttackDelay.is_stopped():
		shoot()
		$AttackDelay.start(attack_delay)
	elif state == STATE.SEARCHING:
		move(get_nearest_enemy().position)
		


func _on_SearchTimer_timeout() -> void:
	if state == STATE.SEARCHING:
		state = STATE.PATROLLING


func _on_PistolBot_died() -> void:
	state = STATE.DEAD
	$AnimatedSprite.animation = "hit"
	$HitBox.set_deferred("disabled", true)
	$AnimatedSprite.play()
	yield($AnimatedSprite, "animation_finished" )
	queue_free()
