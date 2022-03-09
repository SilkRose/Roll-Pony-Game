extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 100
#const FRICTION = 500
var velocity = Vector2.ZERO
var gravity = 1000
var max_fall_speed = 20
var jump_force = -160
var jump_hold = 0.2
var local_hold = 0
onready var sprite = $Playerx32

func _physics_process(delta):
	#var input_vector = Vector2.ZERO
	#input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#input_vector = input_vector.normalized()
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
	
	print(velocity.y, on_ground)
	if direction > 0:
		sprite.flip_h = false
		$CollisionPolygon2D.scale.x = 0.8
	elif direction < 0:
		sprite.flip_h = true
		$CollisionPolygon2D.scale.x = -0.8
	
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, max_fall_speed, gravity * delta)
	#global_position.x += (velocity.x * delta)
	#global_position.y += (velocity.y * delta)
	
	#if input_vector != Vector2.ZERO:
		#velocity.x = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
