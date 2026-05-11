extends Area2D

signal hit

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area.is_in_group("player"):
		hit.emit()
		queue_free()
