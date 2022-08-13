extends Entity

func _physics_process(_delta: float) -> void:
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")

	var direction = Vector2(0, 0)

	if left:
		direction.x -= 1
	if right:
		direction.x += 1
	if up:
		direction.y -= 1
	if down:
		direction.y += 1
	
	var velocity = direction.normalized() * speed
	
	.move_and_collide(velocity * _delta)
