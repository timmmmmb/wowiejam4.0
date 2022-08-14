extends KinematicBody2D
class_name Entity

export var maxHealth: int = 10
var health: int
export var maxShield: int = 0
var shield: int
export var speed = 10
var current_weapon
var velocity : Vector2 = Vector2(0, 0)
signal died 


func _ready() -> void:
	health = maxHealth
	shield = maxShield


func shoot():
	if current_weapon:
		current_weapon.shoot()


func takeDamage(damage) -> void:
	if shield >= damage:
		shield -= damage
	elif shield + health > damage:
		health -= damage-shield
		shield = 0
	else:
		destroy()


func destroy():
	current_weapon.disable_shooting = true
	emit_signal("died")
