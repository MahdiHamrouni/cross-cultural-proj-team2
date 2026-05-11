extends StaticBody2D

@export var dialogue_filename: String = ""
@export var npc_texture: Texture2D
@export var sprite_scale: Vector2 = Vector2(1, 1)

@onready var player: CharacterBody2D = GameManager.mainCharacter

var dialogue_start: String = "start"
var is_dialog_active: bool = false
var player_nearby: bool = false

func _ready():
	$Sprite2D.scale = sprite_scale
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
		GameManager.show_interact_prompt(true)

func _on_body_exited(body):
	if body == player:
		player_nearby = false
		GameManager.show_interact_prompt(false)

func _get_dialogue_resource() -> DialogueResource:
	var lang = TranslationServer.get_locale().substr(0, 2)
	var path = "res://dialogues/%s/%s.dialogue" % [lang, dialogue_filename]
	return load(path)

func start_dialogue():
	is_dialog_active = true
	player.process_mode = Node.PROCESS_MODE_DISABLED
	GameManager.show_interact_prompt(false)
	GameManager.show_hud(false)
	var resource = _get_dialogue_resource()
	DialogueManager.show_dialogue_balloon(resource, dialogue_start)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_resource: DialogueResource):
	is_dialog_active = false
	player.process_mode = Node.PROCESS_MODE_INHERIT
	GameManager.show_hud(true)
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
