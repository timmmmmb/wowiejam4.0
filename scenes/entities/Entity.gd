extends KinematicBody2D
class_name Entity

signal died

export var max_health = 10.0
var health: float
export var max_shield = 0.0
var shield: float
onready var shield_timer = $ShieldTimer
export var shield_regeneration = 20.0
export var speed = 10
var current_weapon
var velocity : Vector2 = Vector2(0, 0)

func _ready() -> void:
	health = max_health
	shield = 0


func _physics_process(delta: float) -> void:
	if shield_timer.is_stopped():
		shield = min(max_shield, shield + shield_regeneration * delta)

func shoot():
	if current_weapon:
		current_weapon.shoot()


func takeDamage(damage) -> void:
	shield_timer.start()
	
	if shield >= damage:
		shield -= damage
	elif shield + health > damage:
		health -= damage-shield
		shield = 0
	else:
		destroy()


func destroy():
	if current_weapon != null:
		current_weapon.disable_shooting = true
	$Death.play()
	emit_signal("died")
