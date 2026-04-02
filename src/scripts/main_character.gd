extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

# Prendi il riferimento al tuo nodo AnimatedSprite2D
@onready var _animated_sprite = $AnimatedSprite2D

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
	var direction = Input.get_vector("move_left", "move_right",
	 "move_up", "move_down")
	velocity = direction * SPEED
	#_animated_sprite.animation = "south"
	move_and_slide()
	
	# movement animation
	if velocity.length() > 0:
		# we control the coordinates has changed
		if abs(direction.x) > abs(direction.y):
			# if x has changed that means is going horizontaly
			if direction.x > 0:
				_animated_sprite.play("right")
			else:
				_animated_sprite.play("left")
		else:
			# if y has changed that means is going verticaly
			if direction.y > 0:
				_animated_sprite.play("down")
			else:
				_animated_sprite.play("up")
	else:
		# if nothing has changed we stay in "idle" state
		_animated_sprite.play("idle")
