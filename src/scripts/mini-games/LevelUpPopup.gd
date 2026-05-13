extends CanvasLayer

@onready var level_label: Label = $Panel/VBoxContainer/LevelLabel
@onready var quote_label: Label = $Panel/VBoxContainer/QuoteLabel
@onready var author_label: Label = $Panel/VBoxContainer/AuthorLabel

func _ready():
	level_label.text = "Level " + str(GameManager.level) + "!"

func set_quote(quote: String, author: String):
	quote_label.text = '"' + quote + '"'
	author_label.text = "— " + author

func _on_continue_pressed():
	queue_free()
