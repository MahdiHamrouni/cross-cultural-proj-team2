extends Area2D

@export var filtered_texture: Texture2D
@export var reality_texture: Texture2D
@export var design_size: Vector2 = Vector2(300, 200)
@export var fall_speed: float = 400.0
@export var reveal_time: float = 0.5
@export var auto_fall_time: float = 5.0
var shake_time: float = 1.0

var is_broken: bool = false
var is_falling: bool = false
var is_shaking: bool = false
var time_alive: float = 0.0
var original_position: Vector2

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	if collision.shape is RectangleShape2D:
		collision.shape.size = design_size
	if filtered_texture:
		_apply_texture_and_rescale(filtered_texture)
	area_entered.connect(_on_area_entered)
	original_position = position

func _process(delta):
	if is_falling:
		position.y += fall_speed * delta
		if position.y > get_viewport_rect().size.y + 100:
			queue_free()
		return
	
	time_alive += delta
	
	if is_shaking:
		position.x = original_position.x + sin(time_alive * 20) * 3
		if time_alive >= auto_fall_time + shake_time:
			is_falling = true
	elif time_alive >= auto_fall_time:
		is_shaking = true

func reveal_reality():
	if is_broken or !reality_texture: return
	is_broken = true
	_apply_texture_and_rescale(reality_texture)
	get_parent().get_parent().post_destroyed()
	await get_tree().create_timer(reveal_time).timeout
	is_falling = true

func _on_area_entered(area):
	if area.is_in_group("player"):
		get_parent().get_parent().player_hit()
		queue_free()

func _apply_texture_and_rescale(tex: Texture2D):
	sprite.texture = tex
	var tex_size = tex.get_size()
	sprite.scale = design_size / tex_size
