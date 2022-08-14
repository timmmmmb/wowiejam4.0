extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var animation_player = $AnimationPlayer
onready var sensor = $Sensor

var open = false


func _physics_process(delta: float) -> void:
	if is_player_in_sensor():
		if not open:
			print("open")
			animation_player.play("open")
			open = true
	else:
		if open:
			print("close")
			animation_player.play_backwards("open")
			open = false


func is_player_in_sensor() -> bool:
	for body in sensor.get_overlapping_bodies():
		if body.is_in_group("Player"):
			return true
	return false
