extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get all the key pressed at the moment and creates a vector object
	# A vector object that is turned into velocity of the character
	# get_vector takes 4 params in order: left, right, up, down
	# that are interpreted in order : -1.x , 1.x , -1.y , 1.y
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	$AnimatedSprite2D.animation = "south"
	move_and_slide()
