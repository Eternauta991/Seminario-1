extends CharacterBody2D

const BALA = preload("res://bala.tscn")
@export var velocidad_bala: float = 800.0 

@onready var animated_sprite: AnimatedSprite2D = $soldado
@onready var arma = $Arma

@onready var punto_disparo = $Agachado/Punto_disparo
@onready var punto_rotacion = $Agachado
@onready var Agachado = $Agachado2
var activar_agachado = false

const SPEED = 200
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	if event.is_action_pressed("Agacharse") and is_on_floor():
		activar_agachado = !activar_agachado
		
		if activar_agachado:
			agacharse()
		else:
			desagacharse()

func _physics_process(delta: float) -> void:
	if not is_on_floor() and not activar_agachado:
		velocity.y += gravity * delta
	if Input.is_action_pressed("ui_accept") and is_on_floor() and not activar_agachado:
		velocity.y += JUMP_VELOCITY
	
	var direccion = Input.get_axis("ui_left","ui_right")
	
	if direccion and not activar_agachado:
		velocity.x = direccion * SPEED 
		animated_sprite.play("default")
		if direccion < 0:
			animated_sprite.flip_h = true   # Mira a la izquierda
			arma.flip_v = true
			arma.position.x = 15
		else:
			animated_sprite.flip_h = false
			arma.flip_v = false
			arma.position.x = -15
	else:
		velocity.x = 0
		animated_sprite.stop() 
	
	if Input.is_action_just_pressed("Disparar") and activar_agachado:
		disparar()
	move_and_slide() 
	rotacion_corporal()

func agacharse():
	Agachado.visible = true
	punto_rotacion.visible = true
	
	animated_sprite.visible = false
	arma.visible = false
	$CollisionShape2D.disabled = true
	$Colission_agachado.disabled = false

func desagacharse():
	Agachado.visible = false
	punto_rotacion.visible = false
	
	animated_sprite.visible = true
	arma.visible = true
	$CollisionShape2D.disabled = false
	$Colission_agachado.disabled = true

func rotacion_corporal():
	if activar_agachado:
		var posicion_mouse = get_local_mouse_position()
		punto_rotacion.look_at(get_global_mouse_position())
		if posicion_mouse.x < 0:
			punto_rotacion.scale.y = -1
			Agachado.flip_h = true 
		elif posicion_mouse.x > 0:
			punto_rotacion.scale.y = 1
			Agachado.flip_h = false   

func disparar():
	var bala_escena = BALA.instantiate()
	bala_escena.rotation = global_rotation
	var _direccion_derecho = Vector2.RIGHT.rotated(global_rotation)
	bala_escena.global_position = punto_disparo.global_position
	
	var posicion_mouse = get_global_mouse_position()
	var direccion = (posicion_mouse - bala_escena.global_position).normalized()
	bala_escena.linear_velocity = direccion * velocidad_bala
	bala_escena.add_collision_exception_with(self)
	get_parent().add_child(bala_escena)
