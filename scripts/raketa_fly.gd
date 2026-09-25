extends Node2D  #библиотека для работы с 2д

var speed = 1  #скорость ракеты
var SBITIE_RAKETI = 0  #счетчик сбитых ракет
var SBIT = false

func _ready() -> void:   #эта функция запустится при старте сцены
	var random_x = randf_range(50, 700 - 50)   #перемещаем существующую стартовую ракету в рандомное место
	$AnimatedSprite2D.position.x = random_x  #перемещаем ракету рандомно по горизонтали
	$AnimatedSprite2D.position.y = -150  #перемещаем ракету ЗА экран к стартовой позиции


func _process(delta: float):
	if SBIT == true or $AnimatedSprite2D.position.y == -300: #если ракета сбита или она находится далеко за экраном в неактивной позиции
		$AnimatedSprite2D.position.y += 0  #ставим скорость перемещения ракеты на ноль
	else:
		$AnimatedSprite2D.position.y += speed+(SBITIE_RAKETI/2)   #скорость перемещения = 1 + (кол-во сбитых ракет : 2)
		if $AnimatedSprite2D.position.y > 760:   #если игрок не успал поймать ракету
			$Label.text = "Сбитые ракеты: %d" % [SBITIE_RAKETI]   #выводим кол-во сбитых ракет
			SBITIE_RAKETI = 0   #обнуляем счетчик ракет для начала новой игры
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:  #обработка щелчка по ракете
	if event is InputEventMouseButton:  #если нажатие это кнопка мыши
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:  #если нажатие это левая кнопка мыши
			SBIT = true
			#$AnimatedSprite2D/Area2D/CollisionShape2DCollisionShape2D.disabled = true #отключаем возможность нажатия на ракету 
			$AudioStreamPlayer.play()  #проигрываем звук попадания
			$AnimatedSprite2D.play("vzriv") #проигрываем анимацию
			await $AnimatedSprite2D.animation_finished   #дожидаемся окончания анимации
			var random_x = randf_range(50, 700 - 50)  #рандомно выбираем куда переместится ракета
			$AnimatedSprite2D.position.x = random_x   #перемещаем ракету рандомно по горизонтали
			$AnimatedSprite2D.position.y = -150   #перемещаем ракету ЗА экран к стартовой позиции
			#$AnimatedSprite2D/Area2D/CollisionShape2DCollisionShape2D.disabled = false #включаем возможность нажатия на ракету 
			$AnimatedSprite2D.play("polet")   #возобновляем проигрывании анимации полета
			SBITIE_RAKETI+=1  #прибавляем сбитую ракету к переменной-счетчику
			SBIT = false
