extends Node2D
class_name Weapon

export(PackedScene) var Projectile = preload("res://scenes/projectiles/Bullet.tscn")
export var delay = 1.0
export var damage = 1
var disable_shooting = false

func _ready() -> void:
	$Delay.wait_time = delay

	
func shoot() -> void:
	if !$Delay.is_stopped() or disable_shooting:
		return
	spawn_bullet()
	$Delay.start(0)
	
	
func spawn_bullet() -> void:
	$Sound.play(0)
	var projectile = Projectile.instance()
	
	projectile.global_position = global_position
	projectile.rotation = global_rotation
	projectile.damage = damage
	get_tree().root.get_child(0).call_deferred("add_child", projectile)
