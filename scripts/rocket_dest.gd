extends Node2D  #библиотека для работы с 2д
	
func _process(delta: float):   #делаем ПОСТОЯННУЮ проверку, успел ли игрок поймать ракету
	if $R/AnimatedSprite2D.position.y > 760:   #если игрок не успел поймать ракету
		var random_x = randf_range(50, 700 - 50)  #телепортируем ракету в неактивную зону
		$R/AnimatedSprite2D.position.x = random_x  #телепортируем ракету в неактивную зону
		$R/AnimatedSprite2D.position.y = -300   #телепортируем ракету в неактивную зону
		game_over()   #активируем функцию 

func game_over():  #эта функция сработает если игрок не успел поймать ракету
	$R/AudioStreamPlayer2.play()  #проигрывается звук проигрыша
	$Fon.hide()   # прячем основной фон
	$Fon2GameOver.show()  #показываем "проигрышный" фон
	$TextureButton.show()   #отображаем кнопку "старт"
	$TextureButton2.show()  #отображаем кнопку "выход"
	$R/Label.show()   #отображаем текст с кол-вом сбитых ракет
	
func _on_texture_button_pressed() -> void:   #если игрок нажал на кнопку "старт"
	$Fon.show()   #показываем основной фон
	$Fon2GameOver.hide()  #прячем "проигрышный" фон
	$TextureButton.hide()  #прячем кнопку "старт"
	$TextureButton2.hide()  #прячем кнопку "выход"
	$R/Label.hide()  #прячем текст
	$R/AnimatedSprite2D.position.y = -150  #телепортируем ракету на стартовую позицию

func _on_texture_button_2_pressed() -> void:  #если игрок нажал на кнопку "выход"
	get_tree().quit()  #закрытие игры
