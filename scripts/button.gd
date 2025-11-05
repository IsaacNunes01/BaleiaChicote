extends Control

func _on_button_pressed():
	print("Mudando para a cena do oceano...")
	get_tree().change_scene_to_file("res://scenes/ocean.tscn")
