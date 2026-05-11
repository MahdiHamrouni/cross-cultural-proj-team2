extends Area2D

@export var speed: float = 300.0
@export var word: String = "Failure"

var direction: Vector2 = Vector2.DOWN
var is_reflected = false

@onready var label: Label = $Label

func _ready():
	body_entered.connect(_on_body_entered)
	if label:
		label.text = word

func _process(delta):
	position += direction * speed * delta
	#print("posizione parola: ", global_position)
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()
	if position.y < -50:
		queue_free()

func reflect():
	is_reflected = true
	direction = Vector2(randf_range(-0.5, 0.5), -1).normalized()
	speed = 400.0

func _on_body_entered(body):
	if body.is_in_group("player") and not is_reflected:
		if body.is_shielding:
			body.shield_uses_left -= 1
			if body.shield_uses_left <= 0:
				body.shield_cooldown = body.SHIELD_COOLDOWN
			reflect()
		else:
			get_parent().player_hit()
			queue_free()
	elif body.is_in_group("boss") and is_reflected:
		get_parent().boss_hit()
		queue_free()
