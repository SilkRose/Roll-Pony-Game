extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = 2
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -2
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 2
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -2
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_collide(velocity)
