extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -450.0
const GRAVITY = 900.0
const SHIELD_MAX_USES: int = 3
const SHIELD_COOLDOWN: float = 8.0

@export var arrow_scene: PackedScene

var is_shielding = false
var can_shoot = true
var is_facing_right = true
var shield_uses_left: int = 3
var shield_cooldown: float = 0.0


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_timer: Timer = $ShootTimer
@onready var collision_normal: CollisionShape2D = $CollisionNormal
@onready var collision_duck: CollisionShape2D = $CollisionDuck
@onready var head_shield: Sprite2D = $HeadShield
@onready var shield_bar: ProgressBar = $"../CanvasLayer/HUD/GridContainer/ShieldBar"

func _ready():
	add_to_group("player")
	collision_duck.disabled = true
	head_shield.visible = false
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shield_bar.value = 100.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if Input.is_action_pressed("move_down"):
			velocity.y += GRAVITY * 3.0 * delta

	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
		is_facing_right = false
	if Input.is_action_pressed("move_right"):
		direction = 1
		is_facing_right = true

	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
	_update_animation()

	if shield_cooldown > 0.0:
		shield_cooldown -= delta
		shield_bar.value = (1.0 - shield_cooldown / SHIELD_COOLDOWN) * 100.0
		if shield_cooldown <= 0.0:
			shield_uses_left = SHIELD_MAX_USES
			shield_bar.value = 100.0

	if shield_cooldown <= 0.0 and shield_uses_left > 0:
		is_shielding = Input.is_action_pressed("ui_accept")
	else:
		is_shielding = false

	head_shield.visible = is_shielding

	if Input.is_action_just_pressed("arrow") and not is_shielding and can_shoot:
		_shoot()

	var is_ducking = Input.is_action_pressed("move_down") and is_on_floor()
	if is_ducking:
		collision_normal.disabled = true
		collision_duck.disabled = false
	else:
		collision_normal.disabled = false
		collision_duck.disabled = true

func _update_animation():
	var is_ducking = Input.is_action_pressed("move_down") and is_on_floor()

	if is_ducking:
		if is_facing_right:
			sprite.play("duck_right")
		else:
			sprite.play("duck_left")
	elif not is_on_floor():
		if is_facing_right:
			sprite.play("jump_right")
		else:
			sprite.play("jump_left")
	else:
		if velocity.x != 0:
			if is_facing_right:
				sprite.play("run_right")
			else:
				sprite.play("run_left")
		else:
			sprite.play("idle")
			sprite.flip_h = false

func _shoot():
	if arrow_scene == null:
		return
	can_shoot = false
	var arrow = arrow_scene.instantiate()
	arrow.position = global_position
	get_parent().add_child(arrow)
	shoot_timer.start(0.5)

func _on_shoot_timer_timeout():
	can_shoot = true

func take_damage():
	get_parent().player_hit()
