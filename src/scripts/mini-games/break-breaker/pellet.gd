extends Area2D

@export var speed: float = 600.0

func _ready():
	area_entered.connect(_on_area_entered)

func _process(delta):
	position.y -= speed * delta
	# Distruggi se esce dallo schermo
	if position.y < -50:
		queue_free()

func _on_area_entered(area):
	if area.has_method("reveal_reality"):
		area.reveal_reality()
		queue_free()
