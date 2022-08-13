extends Entity
export (NodePath) var weapon
enum STATE {IDLE, PATROLLING, ATTACKING, DEAD, SEARCHING}
var state = STATE.IDLE
export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0
export(float) var attack_delay = 1

func _ready() -> void:
	$AttackDelay.wait_time = attack_delay
	current_weapon = get_node(weapon)
	wake_up()

func wake_up():
	state = STATE.PATROLLING
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$AttackDelay.start(rng.randf_range(0,2)+attack_delay)
	$AnimatedSprite.animation = "moving"
	$AnimatedSprite.play()
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(_delta):
	behaviour()

func behaviour():
	if state == STATE.DEAD:
		return
	if patrol_path && state == STATE.PATROLLING:
		var target = patrol_points[patrol_index]
		if position.distance_to(target) < 1:
			patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
			target = patrol_points[patrol_index]
		velocity = (target - position).normalized() * speed
		look_at(target)
		velocity = move_and_slide(velocity)
	var seesEnemy = false
	if state == STATE.ATTACKING && seesEnemy:
		shoot()
		$AttackDelay.start(attack_delay)
		state = STATE.MOVING
