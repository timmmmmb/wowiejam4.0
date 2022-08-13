extends Entity

export var vision_range = 300
export var max_distance_to_player = 100
export var player_path: NodePath

var player: Player

func _ready() -> void:
	player = get_node(player_path)


func _physics_process(_delta: float) -> void:
	var companion_to_player = player.position - position
	var distance_to_player = companion_to_player.abs().length()
	
	if distance_to_player <= vision_range and distance_to_player > max_distance_to_player:
		velocity = companion_to_player.normalized() * speed
		velocity = move_and_slide(velocity)
