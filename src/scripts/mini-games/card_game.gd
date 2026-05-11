extends PanelContainer

@export var scene_path: String = ""
@export var game_title: String = ""
@export var game_description: String = ""
@export var game_image: Texture2D

@onready var title_label: Label = $HBoxContainer/VBoxContainer/Title
@onready var desc_label: Label = $HBoxContainer/VBoxContainer/Description
@onready var play_button: Button = $HBoxContainer/Panel/PlayButton
@onready var image_rect: TextureRect = $HBoxContainer/TextureRect

func _ready():
	title_label.text = game_title
	desc_label.text = game_description
	if game_image:
		image_rect.texture = game_image

func _on_play_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_path)
