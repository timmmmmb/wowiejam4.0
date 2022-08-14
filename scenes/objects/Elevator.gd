extends Sprite

signal entered


func _on_Area2D_body_entered(_body: Node) -> void:
	emit_signal("entered")
