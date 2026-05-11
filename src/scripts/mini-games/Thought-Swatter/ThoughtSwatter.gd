extends Node2D

@export var word_scene: PackedScene
@export var arrow_scene: PackedScene

@onready var player = $SwatterPlayer
@onready var boss = $Boss
@onready var health_label: Label = $CanvasLayer/HUD/GridContainer/HealthLabel
@onready var intro_panel = $CanvasLayer/IntroPanel
@onready var final_panel = $CanvasLayer/FinalPanel
@onready var final_message: Label = $CanvasLayer/FinalPanel/VBoxContainer/FinalMessage

var player_health: int = 3
var spawn_timer: Timer
var game_over = false
var difficulty: float = 1.0
var elapsed_time: float = 0.0
var high_score: float = 0.0

func _ready():
	final_panel.visible = false
	_load_high_score()
	if GameManager.intro_shown:
		intro_panel.visible = false
		_start_game()
	else:
		get_tree().paused = true
		intro_panel.visible = true
	boss.defeated.connect(_on_boss_defeated)

func _process(delta):
	if game_over:
		return
	elapsed_time += delta
	difficulty = min(difficulty + 0.02 * delta, 3.0)
	if spawn_timer:
		spawn_timer.wait_time = max(0.5, 2.0 / difficulty)

func _start_game():
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_spawn_word)
	spawn_timer.start()
	player.arrow_scene = arrow_scene

func _spawn_word():
	if word_scene == null or game_over:
		return
	var w = word_scene.instantiate()
	w.position = Vector2(
		boss.global_position.x + randf_range(-50, 50),
		boss.global_position.y + 50
	)
	w.word = boss.get_random_word()
	var precision = clamp(difficulty / 3.0, 0.0, 1.0)
	var random_offset = Vector2(randf_range(-100, 100), randf_range(-50, 50)) * (1.0 - precision)
	var target = player.global_position + random_offset
	w.direction = (target - w.position).normalized()
	w.speed = 300.0 * difficulty
	add_child(w)

func player_hit():
	if game_over:
		return
	player_health -= 1
	health_label.text = str(player_health)
	if player_health <= 0:
		_end_game(false)

func boss_hit():
	boss.take_damage()

func _on_boss_defeated():
	_end_game(true)

func _end_game(won: bool):
	game_over = true
	get_tree().paused = true
	final_panel.visible = true
	if won:
		if high_score == 0.0 or elapsed_time < high_score:
			high_score = elapsed_time
			_save_high_score()
		var minutes = int(elapsed_time) / 60
		var seconds = int(elapsed_time) % 60
		var hs_minutes = int(high_score) / 60
		var hs_seconds = int(high_score) % 60
		final_message.text = "You silenced the voice.\nIt will come back — but now you know you can beat it.\n\nYour time: %02d:%02d\nBest time: %02d:%02d" % [minutes, seconds, hs_minutes, hs_seconds]
	else:
		final_message.text = "The voice was loud today.\nThat's okay. Try again."

func _load_high_score():
	if FileAccess.file_exists("user://swatter_highscore.dat"):
		var file = FileAccess.open("user://swatter_highscore.dat", FileAccess.READ)
		high_score = file.get_double()
		file.close()

func _save_high_score():
	var file = FileAccess.open("user://swatter_highscore.dat", FileAccess.WRITE)
	file.store_double(high_score)
	file.close()

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
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/journey.tscn")
