extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var npc_inicial: CharacterBody2D = $"."  
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var tutorial_ui: Control = $TutorialUI


func _ready() -> void:
	tutorial_ui.visible = false

func _process(delta: float) -> void:
	# Verifica se o RayCast2D está colidindo com algo
	if ray_cast_2d.is_colliding():
		var alvo = ray_cast_2d.get_collider()
		# Se colidiu com o jogador e o tutorial ainda não foi mostrado
		if alvo != null and alvo.is_in_group("player"):
			mostrar_tutorial()

func mostrar_tutorial():
	tutorial_ui.visible = true
	await get_tree().create_timer(9).timeout  # Mantém o tutorial na tela por 9 segundos
	tutorial_ui.visible = false  # Esconde o tutorial
