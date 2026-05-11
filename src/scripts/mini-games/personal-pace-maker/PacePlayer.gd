extends CharacterBody2D

const JUMP_FORCE = -550.0
const GRAVITY_UP = 800.0
const GRAVITY_DOWN = 1800.0
const SLOWDOWN_FACTOR = 0.4
const SLOWDOWN_DURATION = 1.5

@export var camera_offset: Vector2 = Vector2(0, 0)

var slowdown_timer = 0.0
var is_ducking = false
var current_speed: float = 150.0

@onready var camera: Camera2D = $Camera2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_collision: CollisionShape2D = $hit/collisionShape

func _ready():
	add_to_group("player")
	camera.offset = camera_offset

func _physics_process(delta):
	if not is_on_floor():
		if Input.is_action_pressed("move_down"):
			velocity.y += GRAVITY_DOWN * 3.0 * delta
		elif velocity.y < 0:
			velocity.y += GRAVITY_UP * delta
		else:
			velocity.y += GRAVITY_DOWN * delta

	if Input.is_action_pressed("shoot") and is_on_floor():
		velocity.y = JUMP_FORCE

	is_ducking = Input.is_action_pressed("move_down") and is_on_floor()

	if slowdown_timer > 0.0:
		slowdown_timer -= delta
		velocity.x = current_speed * SLOWDOWN_FACTOR
	else:
		velocity.x = current_speed

	move_and_slide()
	_update_animation()

	var shape = hit_collision.shape as RectangleShape2D
	if is_ducking:
		shape.size.y = 110.0
		hit_collision.position.y = -35.0
	elif not is_on_floor():
		shape.size.y = 135.0
		hit_collision.position.y = -55.0
	else:
		shape.size.y = 140.0
		hit_collision.position.y = -50.0

func _update_animation():
	if is_ducking:
		sprite.play("duck")
	elif not is_on_floor():
		sprite.play("jump")
	else:
		sprite.play("run")

func apply_slowdown():
	slowdown_timer = SLOWDOWN_DURATION
