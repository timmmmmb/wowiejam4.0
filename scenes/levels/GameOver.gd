extends Node2D


func _ready() -> void:
	visible = false


func _physics_process(delta: float) -> void:
	var accept = Input.is_action_just_pressed("ui_accept")
	
	if visible and accept:
		get_tree().reload_current_scene()
		get_tree().paused = false
