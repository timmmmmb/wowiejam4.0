extends KinematicBody2D
class_name Entity

signal died

export var max_health = 10.0
var health: float
export var max_shield = 0.0
var shield: float
var shield_timer: Timer
export var shield_cooldown = 1.0
export var shield_regeneration = 20.0
export var speed = 10
var current_weapon
var velocity : Vector2 = Vector2(0, 0)


func _ready() -> void:
	shield_timer = Timer.new()
	shield_timer.one_shot = true
	shield_timer.wait_time = shield_cooldown
	get_tree().root.get_child(0).call_deferred("add_child", shield_timer)

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
	current_weapon.disable_shooting = true
	emit_signal("died")
