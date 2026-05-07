extends CharacterBody2D

const SPEED = 150.0
const JUMP_FORCE = -380.0
const GRAVITY = 900.0

func _physics_process(delta):
	# Gravità
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Salto con spazio
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Il giocatore avanza sempre automaticamente
	velocity.x = SPEED

	move_and_slide()
