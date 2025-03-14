extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Area2D/AnimatedSprite2D
@onready var informa__o: Node2D = $"."
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var control: Control = $Area2D/Control
@onready var label: Label = $Area2D/Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.autoplay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if collision_shape_2d.one_way_collision:
			var alvo = collision_shape_2d.get_collider()
			if alvo != null and alvo.is_in_group("player"):
				label.text = "Bem Vindo a WARII"
