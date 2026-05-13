extends Area2D

signal damaged
signal defeated

@export var max_health: int = 20
@export var move_speed: float = 100.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar

var health: int
var direction: float = 1.0
var screen_width: float
var initial_scale: Vector2

const WORDS_IT = [
	"Fallito", "Debole", "Brutto",
	"Inutile", "Patetico", "Perdente"
]

const WORDS_EN = [
	"Failure", "Weak", "Ugly",
	"Worthless", "Pathetic", "Loser"
]

func _ready():
	health = max_health
	health_bar.value = 100.0
	screen_width = get_viewport_rect().size.x
	add_to_group("boss")
	initial_scale = sprite.scale

func _process(delta):
	var speed_multiplier: float
	if health <= max_health * 0.3:
		speed_multiplier = 3.0 + (1.0 - float(health) / max_health) * 5.0
	else:
		speed_multiplier = 0.3 + (1.0 - float(health) / max_health) * 1.5

	position.x += direction * move_speed * speed_multiplier * delta
	if position.x > screen_width - 100:
		direction = -1.0
	if position.x < 100:
		direction = 1.0

func take_damage():
	health -= 1
	health_bar.value = float(health) / max_health * 100.0
	var scale_factor = 0.5 + (float(health) / max_health) * 0.5
	sprite.scale = initial_scale * scale_factor
	damaged.emit()
	if health <= 0:
		defeated.emit()
		queue_free()

func get_random_word() -> String:
	var lang = TranslationServer.get_locale().substr(0, 2)
	var words = WORDS_IT if lang == "it" else WORDS_EN
	return words[randi() % words.size()]
