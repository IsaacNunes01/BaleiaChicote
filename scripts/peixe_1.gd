extends CharacterBody2D


const SPEED = 90.0


func _physics_process(delta: float) -> void:
	velocity.y = -SPEED
	move_and_slide()
	
func _on_body_entered(CharacterBody2D):
	if CharacterBody2D.name == "Player":  # se o que encostou for o jogador
		$AudioStreamPlayer2D.play()  # toca o som
		hide()  # faz o peixe sumir
		set_deferred("collision_layer", 0)  # impede novas colisões
		set_deferred("collision_mask", 0)


func _on_area_2d_body_entered(CharacterBody2D: Node2D) -> void:
	pass # Replace with function body.
