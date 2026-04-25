extends StaticBody2D

@export var dialogue_resource: DialogueResource
@export var npc_texture: Texture2D
var dialogue_start: String = "start"

@onready var player: CharacterBody2D = GameManager.mainCharacter

var is_dialog_active: bool = false
var player_nearby: bool = false

func _ready():
	$ProximityArea.body_entered.connect(_on_body_entered)
	$ProximityArea.body_exited.connect(_on_body_exited)
	if npc_texture != null:
		$Sprite2D.texture = npc_texture

func _unhandled_input(event):
	if player_nearby and event.is_action_pressed("interact"):
		if not is_dialog_active:
			start_dialogue()

func _on_body_entered(body):
	if body == player:
		player_nearby = true
		GameManager.show_interact_prompt(true)  # dici al GameManager di mostrare il prompt

func _on_body_exited(body):
	if body == player:
		player_nearby = false
		GameManager.show_interact_prompt(false)

func start_dialogue():
	is_dialog_active = true
	player.process_mode = Node.PROCESS_MODE_DISABLED
	GameManager.show_interact_prompt(false)  # nasconde il prompt
	GameManager.show_hud(false)              # nasconde tutto il CanvasLayer
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_resource: DialogueResource):
	is_dialog_active = false
	player.process_mode = Node.PROCESS_MODE_INHERIT
	GameManager.show_hud(true)               # rimostra il CanvasLayer
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
