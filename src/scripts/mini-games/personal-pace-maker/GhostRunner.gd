extends Node2D

var speed: float = 200.0

@onready var sprite: AnimatedSprite2D = $Ghost
@onready var ground: TileMapLayer = $Ground

func _ready():
	sprite.play("run")

func _process(delta):
	position.x += speed * delta
