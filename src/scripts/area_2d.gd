# DoorTrigger.gd
extends Area2D

@onready var dialog = $"../DialogMenu"

const QUESTION = "You're at the school entrance. What do you do?"
const CHOICES = ["Enter the school", "Look through the window", "Leave"]

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().paused = true
		dialog.show_dialog(QUESTION, CHOICES)
		dialog.choice_made.connect(_on_choice_made, CONNECT_ONE_SHOT)

func _on_choice_made(index: int):
	get_tree().paused = false
	match index:
		0:
			# e.g. change scene to school interior
			# get_tree().change_scene_to_file("res://scenes/school_interior.tscn")
			print("Entering school...")
		1:
			print("Peeking through the window...")
		2:
			print("Walking away.")
