extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine

onready var collider: CollisionShape2D = $NormalCollision

const FLOOR_NORMAL: = Vector2.UP

var is_active: = true setget set_is_active


func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value


#const FLOOR = Vector2.UP
#const FLOOR_MAX_DEG = deg2rad(45)
#const SNAP_DIR = Vector2.DOWN
#const SNAP_LEN = 32
#
#enum {
#	idle,
#	idle_long
#	trot,
#	gallop,
#	sneak,
#	roll,
#	sneak_roll,
#	jump,
#	sneak_jump,
#	wall_jump,
#	wall_slide,
#	buck,
#	attack,
#	damage,
#	dead,
#	victory
#}
#
#var state = idle
#var wall_jumping = false
#var wall_jump_dir = 0
#
#export var move_speed = 80
#export var acceleration = 800
#var sneak_speed = move_speed * 0.50
#var sneak_accel = acceleration * 0.75
#var velocity := Vector2.ZERO
#var snap_vector = SNAP_DIR * SNAP_LEN
#
#export var jump_height : float
#export var jump_time_to_peak : float
#export var jump_time_to_descent : float
#onready var idlesprite = $PlayerIdle2
#onready var trotsprite = $PlayerTrot
#onready var normal_collision = $NormalCollision
#onready var sprite_sneak = $PlayerSneak
#onready var sneak_collision = $SneakCollision
#onready var leftwallray = $LeftWallRay
#onready var rightwallray = $RightWallRay
#onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
#onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
#onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
#
#
#
#func _physics_process(delta):
#	match state:
#		idle:
#			idle_state()
#		trot:
#			trot_state()
#		gallop:
#			gallop_state()
#		sneak:
#			sneak_state()
#
#
#	velocity.y += get_gravity() * delta
#
#	if state == idle:
#		velocity.x = move_toward(velocity.x, move_speed * get_input_velocity(), acceleration * delta)
#	else:
#		velocity.x = move_toward(velocity.x, sneak_speed * get_input_velocity(), sneak_accel * delta)
#
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		jump()
#	elif Input.is_action_just_pressed("jump") and !is_on_floor() and is_on_wall() and !wall_jumping:
#		wall_jump()
#
#	if wall_jumping:
#		if rightwallray.is_colliding():
#			wall_jump_dir = -60
#		elif leftwallray.is_colliding():
#			wall_jump_dir = 60
#		velocity.x = wall_jump_dir
#		if velocity.y <= -1.0:
#			wall_jumping = false
#
#
#	if global_position.y > 400:
#		global_position.x = 0
#		global_position.y = 0
#
#	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR, true, 4, FLOOR_MAX_DEG)
#
#func idle_state():
#	idlesprite.playing = true
#	idlesprite.visible = true
#	if get_input_velocity() != 0:
#		state = trot
#		idlesprite.playing = false
#		idlesprite.visible = false
##	if Input.is_action_just_pressed("sneak") and state == idle:
##		state = sneak
##	else:
##		sprite.visible = true
##		normal_collision.disabled = false
##		sprite_sneak.visible = false
##		sneak_collision.disabled = true
#
#func trot_state():
#	trotsprite.visible = true
#	trotsprite.playing = true
#	if velocity.x > 40 or velocity.x < -40:
#		state = gallop
#	elif velocity == Vector2.ZERO:
#		state = idle
#		trotsprite.visible = false
#		trotsprite.playing = false
#
#func gallop_state():
#	print("gallop")
#
#func sneak_state():
#	#sprite.visible = false
#	normal_collision.disabled = true
#	sprite_sneak.visible = true
#	sneak_collision.disabled = false
#	if Input.is_action_just_pressed("sneak") and state == sneak:
#		state = idle
#
#
#func get_gravity() -> float:
#	if state == idle:
#		snap_vector = Vector2.ZERO
#		return jump_gravity if velocity.y < 0.0 else fall_gravity
#	else:
#		snap_vector = Vector2.ZERO
#		return jump_gravity * 2 if velocity.y < 0.0 else fall_gravity
#
#func jump():
#	velocity.y = jump_velocity
#
#func wall_jump():
#	wall_jumping = true
#	velocity.y = jump_velocity
#
#func get_input_velocity() -> float:
#	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	animate_sprite(horizontal)
#	return horizontal
#
#func animate_sprite(direction):
#	if direction > 0:
#		idlesprite.flip_h = false
#		sprite_sneak.flip_h = false
#	elif direction < 0:
#		idlesprite.flip_h = true
#		sprite_sneak.flip_h = true
