extends Area2D

@export var speed: float = 500.0

func _ready():
	area_entered.connect(_on_area_entered)

func _process(delta):
	position.y -= speed * delta
	if position.y < -50:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("boss"):
		get_parent().boss_hit()
		queue_free()
