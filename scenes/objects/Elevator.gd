extends Sprite

signal entered
export var fixGreen = false


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("entered")
	if fixGreen:
		$GreenElevatorLight.enabled = true
		$RedElevatorLight.enabled = false
	else:
		$GreenElevatorLight.enabled = true
		$RedElevatorLight.enabled = false


func _on_Area2D_body_exited(_body: Node) -> void:
	if fixGreen:
		$GreenElevatorLight.enabled = true
		$RedElevatorLight.enabled = false
	else:
		$GreenElevatorLight.enabled = false
		$RedElevatorLight.enabled = true
