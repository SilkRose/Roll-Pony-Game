extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 100
#const FRICTION = 500
var velocity = Vector2.ZERO
var gravity = 1000
var max_fall_speed = 160
onready var sprite = $Playerx32

func _physics_process(delta):
	#var input_vector = Vector2.ZERO
	#input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#input_vector = input_vector.normalized()
	var direction = sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if direction > 0:
		sprite.flip_h = false
		$CollisionPolygon2D.scale.x = 0.8
	elif direction < 0:
		sprite.flip_h = true
		$CollisionPolygon2D.scale.x = -0.8
	
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, max_fall_speed, gravity * delta)
	global_position.x += (velocity.x * delta)
	global_position.y += (velocity.y * delta)
	
	#if input_vector != Vector2.ZERO:
		#velocity.x = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#velocity = move_and_slide(velocity)
