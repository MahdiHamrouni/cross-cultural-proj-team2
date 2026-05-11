extends Area2D

signal collected

var base_y: float
var time: float = 0.0

func _ready():
	base_y = position.y
	area_entered.connect(_on_area_entered)

func _process(delta):
	time += delta
	position.y = base_y + sin(time * 2.0) * 8.0

func _on_area_entered(area):
	if area.is_in_group("player"):
		collected.emit()
		queue_free()
