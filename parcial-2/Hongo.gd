# DENTRO DEL SCRIPT DEL HONGO (character_body_2d.gd)
extends CharacterBody2D

@export var puerta_a_abrir: AnimatableBody2D

func recibir_dano(_cantidad: int):

	if puerta_a_abrir != null:
		puerta_a_abrir.abrir()
	
	# Usamos call_deferred para eliminar al hongo de forma segura y evitar conflictos físicos
	queue_free() 
