extends CharacterBody2D

@export var speed: float = 150.0

func _ready():
	# Garante que o Area2D está ativo
	# garante Area2D existe e conecta sinal com segurança
	if has_node("Area2D"):
		var area = $Area2D
		area.monitoring = true
		if not area.body_entered.is_connected(_on_area_body_entered):
			area.body_entered.connect(_on_area_body_entered)
		print("[Peixe] _ready: sinal conectado ao Area2D")
	else:
		print("[Peixe] ERRO: Area2D não encontrada")

func mudar_de_cena():
	if get_tree():
		get_tree().change_scene_to_file("res://derrota.tscn")
		

func _physics_process(delta):
	velocity.y = -speed
	move_and_slide()

func _on_area_body_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		# Toca a animação do Player1
		if body.has_node("AnimationPlayer"):
			var anim = body.get_node("AnimationPlayer")
			anim.play("animacaochicotada")

		if has_node("AudioChicote"):
			var player = $AudioChicote
			if player.stream:
				player.play()


		if has_node("CollisionShape2D"):
			$CollisionShape2D.disabled = true
		if has_node("Area2D/CollisionShape2D"):
			$Area2D/CollisionShape2D.disabled = true

		# Faz o peixe sumir depois de um pequeno tempo (pra não crashar durante a colisão)
		hide()
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)
		await get_tree().create_timer(1.0).timeout
		if is_inside_tree():
			queue_free()
		Global.zerarpontos()
	# debug - sempre imprime quem tocou
	print("[Peixe] area entered por:", body, " name=", body.name, " class=", body.get_class())

	# aceita Player2 por nome OU por grupo "player2" (mais robusto)
	print("[Peixe] area entered por:", body, " name=", body.name)
	if body.name == "Player2" or body.is_in_group("player2"):
		print("[Peixe] tocou Player2 -> informando Global")
		# chama o método global (assumindo que Global está configurado como Autoload)
		Global.adicionar_ponto()
		if has_node("AudioBaleia"):
			var player = $AudioBaleia
			if player.stream:
				player.play()

		# desativa colisões e esconde o peixe
		if has_node("CollisionShape2D"):
			$CollisionShape2D.disabled = true
		var area_shape = $Area2D.get_node_or_null("CollisionShape2D")
		if area_shape:
			area_shape.disabled = true

		hide()
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)

		await get_tree().create_timer(1.0).timeout
		if is_inside_tree():
			queue_free()
			
