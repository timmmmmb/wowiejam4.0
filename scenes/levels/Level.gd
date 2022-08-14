extends Node2D

onready var game_over_ui = $Player/GameOver
onready var victory_ui = $Player/Victory


func victory() -> void:
	victory_ui.visible = true
	get_tree().paused = true


func game_over() -> void:
	game_over_ui.visible = true
	get_tree().paused = true


func _on_Player_died() -> void:
	game_over()


func _on_Companion_died() -> void:
	game_over()


func _on_Elevator_entered() -> void:
	victory()
