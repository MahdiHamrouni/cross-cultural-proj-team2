extends TextureButton

# Esporta le variabili per poterle impostare dall'Inspector
@export var dialogue_resource: DialogueResource  # Il tuo file .dialogue
@export var interaction_distance: float = 150.0  # Distanza massima per interagire
var dialogue_start: String = "start"

# Riferimento al giocatore. Dovrai trascinarlo nell'Inspector.
@onready var player: CharacterBody2D = $"../mainCharacter";

# Variabile per gestire lo stato del dialogo (evita click multipli)
var is_dialog_active: bool = false

func _ready():
	# Collega il segnale "pressed" del bottone alla funzione che gestirà il click
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	# Se un dialogo è già attivo, ignora il click
	if is_dialog_active:
		return

	# Controlla se il riferimento al giocatore è stato impostato
	if player == null:
		print("Errore: Riferimento al giocatore non impostato per l'NPC!")
		return

	# Calcola la distanza tra l'NPC (il bottone) e il giocatore
	# global_position è la posizione del nodo nello spazio globale del mondo di gioco
	var distance = global_position.distance_to(player.global_position)

	# Se il giocatore è abbastanza vicino, avvia il dialogo
	if distance <= interaction_distance:
		start_dialogue()
	else:
		# Opzionale: un feedback per il giocatore
		print("Sei troppo lontano per parlare con quest'NPC.")
		# Potresti mostrare un messaggio a schermo per qualche secondo

func start_dialogue():
	
	
	# Impedisce di avviare un nuovo dialogo mentre questo è attivo
	is_dialog_active = true

	player.process_mode = Node.PROCESS_MODE_DISABLED

	# Disabilita il movimento del giocatore, se necessario (opzionale)
	# get_tree().call_group("player", "set_can_move", false)

	# Avvia il dialogo usando l'API del plugin
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)

	# Collega il segnale di fine dialogo per eseguire delle azioni di pulizia
	# La funzione '_on_dialogue_ended' verrà chiamata automaticamente quando il dialogo finisce
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_resource: DialogueResource):
	# Riabilita il movimento del giocatore (se era stato disabilitato)
	# get_tree().call_group("player", "set_can_move", true)

	# Permette di avviare un nuovo dialogo in futuro
	is_dialog_active = false
	
	player.process_mode = Node.PROCESS_MODE_INHERIT

	# È buona norma disconnettersi dal segnale per evitare comportamenti indesiderati
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
