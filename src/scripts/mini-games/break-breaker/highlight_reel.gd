extends Node2D

@export var post_scene: PackedScene
@export var spawn_interval: float = 1.0

@onready var label_vite: Label = $Control/HUDPanel/VBoxContainer/LivesContainer/LivesLabel
@onready var label_punteggio: Label = $Control/HUDPanel/VBoxContainer/XPContainer/XPLabel
@onready var final_score_panel = $CanvasLayer/FinalScore
@onready var ur_score_label: Label = $CanvasLayer/FinalScore/VBoxContainer/YourScore/urScore
@onready var hg_score_label: Label = $CanvasLayer/FinalScore/VBoxContainer/HighestScore/hgScore
@onready var intro_panel = $CanvasLayer/IntroPanel
@onready var spawn_timer: Timer = Timer.new()

var filtered_images: Array = []
var reality_images: Array = []
var lives: int = 3
var score: int = 0
var difficulty: float = 1.0
var high_score: int = 0
var min_spawn_interval: float = 0.6  # limite minimo spawn
var return_to_minigame_menu: bool = false

func _ready():
	if GameManager.intro_shown:
		intro_panel.visible = false
		_start_game()
	else:
		get_tree().paused = true
		intro_panel.visible = true
	
	final_score_panel.visible = false
	_load_high_score()
	
	label_vite.text = str(lives)
	label_punteggio.text = str(score)
	
	var panel = $Control/HUDPanel
	var viewport_size = get_viewport_rect().size
	panel.position = (viewport_size - panel.size) / 2
	$Control/Background.size = get_viewport_rect().size
	
	_load_images()
	
	if filtered_images.is_empty():
		print("Errore: nessuna immagine trovata nelle cartelle!")
		return

func _start_game():
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_spawn_post)
	spawn_timer.start()

func _load_images():
	var filtered_dir = DirAccess.open("res://assets/images/mini-games/break-breaker/filtered/")
	var reality_dir = DirAccess.open("res://assets/images/mini-games/break-breaker/reality/")
	
	if filtered_dir == null or reality_dir == null:
		print("Errore: cartelle non trovate!")
		return
	
	var files = filtered_dir.get_files()
	files.sort()
	
	for file in files:
		if file.ends_with(".png") or file.ends_with(".jpg"):
			filtered_images.append(load("res://assets/images/mini-games/break-breaker/filtered/" + file))
			reality_images.append(load("res://assets/images/mini-games/break-breaker/reality/" + file))
	
	print("Caricate ", filtered_images.size(), " coppie di immagini")

func _spawn_post():
	if post_scene == null or filtered_images.is_empty():
		return
	
	var post = post_scene.instantiate()
	var random_index = randi() % filtered_images.size()
	post.filtered_texture = filtered_images[random_index]
	post.reality_texture = reality_images[random_index]
	
	var screen_width = get_viewport_rect().size.x
	var random_x = randf_range(100, screen_width - 100)
	post.position = Vector2(random_x, 100)
	
	$Posts.add_child(post)
	
	# velocità crescente
	post.fall_speed = 200.0 * difficulty
	difficulty += 0.01
	
	# spawn interval crescente — più difficile nel tempo
	spawn_timer.wait_time = max(min_spawn_interval, spawn_interval / difficulty)

func player_hit():
	lives -= 1
	label_vite.text = str(lives)
	if lives <= 0:
		game_over()

func post_destroyed():
	score += 1
	label_punteggio.text = str(score)

func game_over():
	GameManager.add_xp(score * 10)
	if score > high_score:
		high_score = score
		_save_high_score()
	
	ur_score_label.text = str(score)
	hg_score_label.text = str(high_score)
	final_score_panel.visible = true
	get_tree().paused = true

func _load_high_score():
	if FileAccess.file_exists("user://highscore.dat"):
		var file = FileAccess.open("user://highscore.dat", FileAccess.READ)
		high_score = file.get_32()
		file.close()

func _save_high_score():
	var file = FileAccess.open("user://highscore.dat", FileAccess.WRITE)
	file.store_32(high_score)
	file.close()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	GameManager.intro_shown = false
	GameManager.return_to_minigame_menu = true
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/journey.tscn")

func _on_start_pressed() -> void:
	GameManager.intro_shown = true
	get_tree().paused = false
	intro_panel.visible = false
	_start_game()
