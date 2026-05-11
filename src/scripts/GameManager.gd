extends Node

var mainCharacter: CharacterBody2D = null
@onready var interact_prompt: Label = null
var canvas_layer: CanvasLayer = null
var total_xp: int = 0
var level: int = 1
var return_to_minigame_menu: bool = false
var intro_shown: bool = false

func _ready() -> void:
	load_xp()

func show_interact_prompt(value: bool):
	if interact_prompt != null:
		interact_prompt.visible = value

func show_hud(value: bool):
	if canvas_layer != null:
		canvas_layer.visible = value

func add_xp(amount: int):
	total_xp += amount
	save_xp()
	_check_level_up()

func _check_level_up():
	var xp_needed = level * 100
	if total_xp >= xp_needed:
		total_xp -= xp_needed
		level += 1
		save_xp()

func save_xp():
	var file = FileAccess.open("user://xp.dat", FileAccess.WRITE)
	file.store_32(total_xp)
	file.store_32(level)
	file.close()

func load_xp():
	if FileAccess.file_exists("user://xp.dat"):
		var file = FileAccess.open("user://xp.dat", FileAccess.READ)
		total_xp = file.get_32()
		level = file.get_32()
		file.close()
