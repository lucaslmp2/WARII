extends Area2D

@onready var area_2d: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var control: Control = $Control
@onready var label: Label = $Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.animation = "quest"
	
	# Exibir mensagem de boas-vindas no Label
	label.text = "Bem-vindo ao jogo!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
