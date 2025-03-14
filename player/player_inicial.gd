extends CharacterBody2D

const SPEED = 300.0
const WALK_SPEED = 150.0  # Velocidade reduzida ao andar
const JUMP_VELOCITY = -400.0
const GRAVITY = 980  

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D

var is_attacking = false
var is_dead = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Adicionar gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

		# Animação de pulo ou queda
		if velocity.y < 0:
			animated_sprite_2d.play("pular")
		elif velocity.y > 0:
			animated_sprite_2d.play("cair")

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("pular")

	# Ataque
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		velocity.x = 0  # Para o personagem durante o ataque
		animated_sprite_2d.play("atack")
		await animated_sprite_2d.animation_finished
		is_attacking = false

	# Movimento (andar ou correr)
	var direction := Input.get_axis("ui_left", "ui_right")
	var walk_left := Input.is_action_pressed("walk_left")
	var walk_right := Input.is_action_pressed("walk_right")
	var is_walking := walk_left or walk_right  # Verifica se alguma tecla de andar foi pressionada
	
	if direction != 0 and not is_attacking:
		velocity.x = direction * (WALK_SPEED if is_walking else SPEED)
		animated_sprite_2d.flip_h = direction < 0

		if is_on_floor():
			animated_sprite_2d.play("andar" if is_walking else "correr")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # Para suavizar a desaceleração

		# Se estiver no chão e não estiver atacando, fique parado
		if is_on_floor() and not is_attacking:
			animated_sprite_2d.play("idle")

	move_and_slide()

func die():
	if not is_dead:
		is_dead = true
		animated_sprite_2d.play("morte")
		await animated_sprite_2d.animation_finished
		queue_free()
