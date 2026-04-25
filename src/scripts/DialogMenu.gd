# DialogMenu.gd
extends CanvasLayer

signal choice_made(index)

@onready var question_label = $PanelContainer/VBoxContainer/Label
@onready var choices_container = $PanelContainer/VBoxContainer/ChoicesContainer

func _ready():
	hide()
	# Keep UI working while game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_dialog(question: String, choices: Array):
	question_label.text = question
	for child in choices_container.get_children():
		child.queue_free()
	for i in choices.size():
		var btn = Button.new()
		btn.text = choices[i]
		btn.pressed.connect(func(): _on_choice(i))
		choices_container.add_child(btn)
	show()

func _on_choice(index: int):
	emit_signal("choice_made", index)
	hide()
