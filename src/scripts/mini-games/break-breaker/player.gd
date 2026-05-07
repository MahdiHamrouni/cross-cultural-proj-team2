extends Area2D

@export var speed: float = 400.0
@export var pellet_scene: PackedScene

var screen_size: Vector2

func _ready():
	add_to_group("player")
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	
	position.x += velocity.x * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		_shoot()

func _shoot():
	if pellet_scene == null: return
	var pellet = pellet_scene.instantiate()
	pellet.position = position
	get_parent().add_child(pellet)
