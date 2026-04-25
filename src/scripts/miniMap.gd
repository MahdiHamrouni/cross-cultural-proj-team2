extends SubViewport

@onready var player: CharacterBody2D = GameManager.mainCharacter

@onready var camera_2d: Camera2D = $"Camera2D"


func _ready() -> void:
	world_2d = get_tree().root.world_2d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.position = player.position


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
