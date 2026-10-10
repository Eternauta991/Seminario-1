extends Node2D

var iniciando := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jugar") and not iniciando:
		iniciando = true
		get_tree().call_deferred("change_scene_to_file","res://Nivel.tscn")
