extends CharacterBody2D

@export var puerta_a_abrir: AnimatableBody2D

func recibir_dano(_cantidad: int):

	if puerta_a_abrir != null:
		puerta_a_abrir.abrir()
	
	queue_free() 
