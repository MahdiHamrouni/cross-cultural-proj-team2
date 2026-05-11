extends Node2D

@onready var minigames_area: Area2D = $"Mini-Games"
@onready var player: CharacterBody2D = GameManager.mainCharacter
@onready var xp_bar: ProgressBar = $CanvasLayer/VBoxContainer/XPBar
@onready var level_label: Label = $CanvasLayer/VBoxContainer/XPBar/LevelLabel

var minigames_nearby: bool = false

func _ready() -> void:
	GameManager.interact_prompt = $CanvasLayer/InteractPrompt
	GameManager.canvas_layer = $CanvasLayer

	if GameManager.return_to_minigame_menu:
		GameManager.return_to_minigame_menu = false
		_open_minigame_menu()

	minigames_area.body_entered.connect(_on_minigames_entered)
	minigames_area.body_exited.connect(_on_minigames_exited)

func _process(delta: float) -> void:
	xp_bar.max_value = GameManager.level * 100
	xp_bar.value = GameManager.total_xp
	level_label.text = "Lv " + str(GameManager.level)

func _unhandled_input(event):
	if minigames_nearby and event.is_action_pressed("interact"):
		_open_minigame_menu()

func _on_minigames_entered(body):
	if body == player:
		minigames_nearby = true
		GameManager.show_interact_prompt(true)

func _on_minigames_exited(body):
	if body == player:
		minigames_nearby = false
		GameManager.show_interact_prompt(false)

func _open_minigame_menu():
	minigames_nearby = false
	GameManager.show_interact_prompt(false)
	GameManager.show_hud(false)
	player.process_mode = Node.PROCESS_MODE_DISABLED
	var menu = load("res://scenes/mini-games/MiniGameMenu.tscn").instantiate()
	add_child(menu)
	menu.closed.connect(_on_menu_closed)

func _on_menu_closed():
	player.process_mode = Node.PROCESS_MODE_INHERIT
	GameManager.show_hud(true)
