extends RigidBody2D

var velocidad = 500

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.has_method("recibir_dano"):
		body.recibir_dano(20)

	queue_free()
