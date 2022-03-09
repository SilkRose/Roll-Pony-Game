extends KinematicBody2D

var remainder = Vector2.ZERO

func move_x(amount):
	remainder.x += amount
	var move = round(remainder.x)
	if (move != 0):
		remainder.x -= move
		move_x_exact(move)

func move_x_exact(amount):
	var step = sign(amount)
	while (amount != 0):
		global_position.x += step
		amount -= step

func move_y(amount):
	remainder.y += amount
	var move = round(remainder.y)
	if (move != 0):
		remainder.y -= move
		move_y_exact(move)

func move_y_exact(amount):
	var step = sign(amount)
	while (amount != 0):
		global_position.y += step
		amount -= step
