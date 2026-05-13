extends Control

@onready var language_button: Button = $VBoxContainer/language


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_language_button()

func _update_language_button() -> void:
	if TranslationServer.get_locale() == "it":
		language_button.text = "Lingua: Italiano"
	else:
		language_button.text = "Language: English"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/journey.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resources_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/resources.tscn")


func _on_language_pressed() -> void:
	if TranslationServer.get_locale() == "it":
		TranslationServer.set_locale("en")
	else:
		TranslationServer.set_locale("it")
	get_tree().reload_current_scene()
