extends Node

var pontos: int = 0
var _changing_scene: bool = false  # evita chamadas repetidas
func zerarpontos() -> void:
	pontos = 0
func adicionar_ponto() -> void:
	pontos += 1
	print("[Global] pontos =", pontos)
	if pontos >= 5 and not _changing_scene:
		_changing_scene = true
		call_deferred("mudar_de_cena")

func mudar_de_cena() -> void:
	# segurança extra: só troca se a árvore existir
	if get_tree():
		print("[Global] mudando de cena (pontos =", pontos, ")")
		pontos = 0
		get_tree().change_scene_to_file("res://scenes/derrota.tscn")  # <--- ajuste o caminho aqui
	else:
		print("[Global] get_tree() ainda nulo, retrying deferred")
		call_deferred("mudar_de_cena")
