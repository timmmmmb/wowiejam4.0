extends Entity
class_name Player


func _physics_process(_delta: float) -> void:
	move(_delta)


func move(_delta: float) -> void:
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")

	var direction = Vector2(0, 0)

	if left:
		$AnimatedSprite.animation = "left"
		direction.x -= 1
	if right:
		$AnimatedSprite.animation = "right"
		direction.x += 1
	if up:
		$AnimatedSprite.animation = "up"
		direction.y -= 1
	if down:
		$AnimatedSprite.animation = "down"
		direction.y += 1
	
	var velocity = direction.normalized() * speed
	
	if velocity.x == 0 && velocity.y == 0 :
		$AnimatedSprite.animation = "default"
	elif !$Footsteps.playing:
		$Footsteps.play()
	
	velocity = move_and_slide(velocity)

