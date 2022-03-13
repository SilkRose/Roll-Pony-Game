extends KinematicBody2D

const FLOOR = Vector2.UP
const FLOOR_MAX_DEG = deg2rad(45)
const SNAP_DIR = Vector2.DOWN
const SNAP_LEN = 16

export var move_speed = 80
export var acceleration = 800

var velocity := Vector2.ZERO
var snap_vector = SNAP_DIR * SNAP_LEN

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float
onready var sprite = $Playerx32
onready var collision = $CollisionPolygon2D
onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = move_toward(velocity.x, move_speed * get_input_velocity(), acceleration * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	if global_position.y > 100:
		global_position.x = 0
		global_position.y = 0
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR, true, 4, FLOOR_MAX_DEG)

func get_gravity() -> float:
		snap_vector = Vector2.UP * 0
		return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	animate_sprite(horizontal)
	return horizontal

func animate_sprite(direction):
	if direction > 0:
		sprite.flip_h = false
		collision.scale.x = 1
	elif direction < 0:
		sprite.flip_h = true
		collision.scale.x = -1
