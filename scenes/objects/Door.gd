extends StaticBody2D


onready var animation_player = $AnimationPlayer
onready var sensor = $Sensor

var open = false


func _physics_process(_delta: float) -> void:
	if is_character_in_sensor():
		if not open:
			animation_player.play("open")
			open = true
	else:
		if open:
			animation_player.play_backwards("open")
			open = false


func is_character_in_sensor() -> bool:
	for body in sensor.get_overlapping_bodies():
		if body.is_in_group("Entity"):
			return true
	return false
