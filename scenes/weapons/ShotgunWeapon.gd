extends Weapon

export var bullet_amount = 5
export var spread = 30


func spawn_bullet() -> void:
	$Sound.play(0)
	for i in range(bullet_amount):
		var projectile = Projectile.instance()
	
		projectile.position = self.position + get_parent().position
		projectile.rotation = self.rotation + deg2rad((spread / bullet_amount * (i+0.5)) - float(spread / 2))
		get_tree().root.get_child(0).add_child(projectile)
