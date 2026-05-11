extends Node2D

@export var ghost_scene: PackedScene
@export var obstacle_scene: PackedScene
@export var orb_scene: PackedScene
@export var obstacle_textures_low: Array[Texture2D] = []
@export var obstacle_textures_high: Array[Texture2D] = []

@onready var player = $PacePlayer
@onready var orbs_label: Label = $CanvasLayer/HUD/OrbsLabel
@onready var message_label: Label = $CanvasLayer/HUD/MessageLabel
@onready var progress_bar: ProgressBar = $CanvasLayer/HUD/ProgressBar
@onready var intro_panel = $CanvasLayer/IntroPanel
@onready var final_panel = $CanvasLayer/FinalPanel
@onready var final_message: Label = $CanvasLayer/FinalPanel/VBoxContainer/FinalMessage
@onready var final_orbs: Label = $CanvasLayer/FinalPanel/VBoxContainer/FinalOrbs

const TRACK_LENGTH = 32000.0
const STOP_SPAWN_AT = 0.95
const MESSAGES = [
	"Go at your own pace",
	"You don't need to rush",
	"Every step counts",
	"This is your journey",
]

var orbs_collected = 0
var message_index = 0
var message_timer = 0.0
var game_over = false
var difficulty: float = 1.0
var obstacle_timer_node: Timer
var last_obstacle_x: float = 0.0
var player_ground_y: float = 0.0

func _ready():
	final_panel.visible = false
	if GameManager.intro_shown:
		intro_panel.visible = false
		_start_game()
	else:
		get_tree().paused = true
		intro_panel.visible = true

func _start_game():
	player_ground_y = player.position.y
	_spawn_ghosts()

	obstacle_timer_node = Timer.new()
	add_child(obstacle_timer_node)
	obstacle_timer_node.wait_time = 2.5
	obstacle_timer_node.autostart = true
	obstacle_timer_node.timeout.connect(_spawn_obstacle)
	obstacle_timer_node.start()

	var t2 = Timer.new()
	add_child(t2)
	t2.wait_time = 3.0
	t2.autostart = true
	t2.timeout.connect(_spawn_orb)
	t2.start()

func _process(delta):
	if game_over:
		return

	difficulty = min(difficulty + 0.05 * delta, 2.5)
	player.current_speed = 150.0 * difficulty

	if obstacle_timer_node:
		obstacle_timer_node.wait_time = max(0.6, 2.5 / difficulty)

	var progress = clamp(player.position.x / TRACK_LENGTH, 0.0, 1.0)
	progress_bar.value = progress * 100.0

	message_timer += delta
	if message_timer >= 5.0:
		message_timer = 0.0
		message_index = (message_index + 1) % MESSAGES.size()
		message_label.text = MESSAGES[message_index]

	if progress >= 1.0:
		_end_game()

func _spawn_ghosts():
	if ghost_scene == null:
		return
	var speeds = [230.0, 320.0, 420.0]
	for i in range(3):
		var g = ghost_scene.instantiate()
		g.position = Vector2(100.0, player.position.y - 48.0 * (i + 1))
		g.speed = speeds[i]
		g.z_index = -(i + 1)
		$Ghosts.add_child(g)

func _spawn_obstacle():
	if obstacle_scene == null or game_over:
		return
	if player.position.x / TRACK_LENGTH >= STOP_SPAWN_AT:
		return

	var min_distance = max(250.0, 600.0 / difficulty)
	if player.position.x - last_obstacle_x < min_distance:
		return

	last_obstacle_x = player.position.x

	var o = obstacle_scene.instantiate()
	o.z_index = 5
	var is_high = randf() > 0.6

	if is_high:
		o.position = Vector2(
			player.position.x + randf_range(500.0, 900.0),
			player_ground_y - 130.0
		)
		if obstacle_textures_high.size() > 0:
			o.get_node("Sprite2D").texture = obstacle_textures_high[randi() % obstacle_textures_high.size()]
	else:
		o.position = Vector2(
			player.position.x + randf_range(500.0, 900.0),
			player_ground_y
		)
		if obstacle_textures_low.size() > 0:
			o.get_node("Sprite2D").texture = obstacle_textures_low[randi() % obstacle_textures_low.size()]

	o.hit.connect(player_hit)
	$Obstacles.add_child(o)

func _spawn_orb():
	if orb_scene == null or game_over:
		return
	if player.position.x / TRACK_LENGTH >= STOP_SPAWN_AT:
		return
	var orb = orb_scene.instantiate()
	orb.position = Vector2(
		player.position.x + randf_range(300.0, 600.0),
		player_ground_y - randf_range(30.0, 80.0)
	)
	orb.collected.connect(_on_orb_collected)
	$Orbs.add_child(orb)

func _on_orb_collected():
	orbs_collected += 1
	orbs_label.text = "Orb: " + str(orbs_collected)

func player_hit():
	player.apply_slowdown()

func _end_game():
	GameManager.add_xp(orbs_collected * 15)
	game_over = true
	get_tree().paused = true
	final_panel.visible = true
	final_message.text = "Some obstacles hit you anyway — that's life.\nIt doesn't always give you room to dodge.\nWhat matters is that you kept running."
	final_orbs.text = "Progress orbs collected: " + str(orbs_collected)

func _on_start_pressed():
	GameManager.intro_shown = true
	get_tree().paused = false
	intro_panel.visible = false
	_start_game()

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	GameManager.intro_shown = false
	GameManager.return_to_minigame_menu = true
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/journey.tscn")
