extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 75
#const FRICTION = 800
var velocity = Vector2.ZERO
var gravity = 1000
var max_fall_speed = 100
var jump_force = -120
var jump_hold = 0.25
var local_hold = 0
onready var sprite = $Playerx32

func _physics_process(delta):
	var direction = sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	var jumping = Input.is_action_pressed("jump")
	var on_ground = velocity.y == 0
	if on_ground && jumping:
		velocity.y = jump_force
		local_hold = jump_hold
	elif local_hold > 0:
		if jumping:
			velocity.y = jump_force
		else:
			local_hold = 0
	
	local_hold -= delta
	
	if direction > 0:
		sprite.flip_h = false
		$CollisionPolygon2D.scale.x = 0.8
	elif direction < 0:
		sprite.flip_h = true
		$CollisionPolygon2D.scale.x = -0.8
	
	velocity.x = int(move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION * delta))
	velocity.y = int(move_toward(velocity.y, max_fall_speed, gravity * delta))

	print(velocity)
	#if input_vector != Vector2.ZERO:
		#velocity.x = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
