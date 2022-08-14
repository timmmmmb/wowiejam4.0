extends Area2D
class_name Bullet
export (int) var speed = 2
export var isFriendly = false
var damage = 1

func _ready() -> void:
	$AnimatedSprite.play()


func move():
	if $AnimatedSprite.animation != "hit":
		position += Vector2.UP.rotated(rotation) * speed


func _physics_process(_delta):
	move()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func hit():
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.animation = "hit"
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play()
	yield($AnimatedSprite, "animation_finished" )
	queue_free()


func _on_Bullet_body_entered(body: Node) -> void:
	if (body.is_in_group('Enemies') && isFriendly) || (body.is_in_group('Player')  && !isFriendly):
		body.takeDamage(damage)
		hit()
	elif body.is_in_group('Object'):
		hit()
