extends Node

# La variabile che conterrà il riferimento al giocatore
var mainCharacter: CharacterBody2D = null
@onready var interact_prompt: Label = null  
var canvas_layer: CanvasLayer = null

func show_interact_prompt(value: bool):
	if interact_prompt != null:
		interact_prompt.visible = value
		
func show_hud(value: bool):
	if canvas_layer != null:
		canvas_layer.visible = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
