extends Node2D

onready var game_over_ui = $Player/GameOver


func victory() -> void:
	# TODO
	print("victory") 


func game_over() -> void:
	game_over_ui.visible = true
	get_tree().paused = true


func _on_Player_died() -> void:
	game_over()


func _on_Companion_died() -> void:
	game_over()
