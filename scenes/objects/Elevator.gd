extends Sprite

signal entered


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("entered")
	$GreenElevatorLight.enabled = true
	$RedElevatorLight.enabled = false


func _on_Area2D_body_exited(_body: Node) -> void:
	$GreenElevatorLight.enabled = false
	$RedElevatorLight.enabled = true
