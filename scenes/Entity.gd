extends Node2D

export var maxHealth: int = 10
var health: int = maxHealth
export var maxShield: int = 0
export var shield: int = maxShield
signal died 


func takeDamage(damage) -> void:
	if shield >= damage:
		shield -= damage
	elif shield + health > damage:
		health -= damage-shield
		shield = 0
	else:
		emit_signal("died")
		
