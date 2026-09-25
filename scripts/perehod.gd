extends Node  #библиотека для работы с НОДами (элементами игры)

func _on_texture_button_pressed() -> void:   #если игрок нажал на кнопку "старт"
	get_tree().change_scene_to_file("res://scenes/game.tscn")  #переход на основную сцену игры
