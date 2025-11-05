extends Control

var imba_video = load("res://Sprites/Video/Imba.ogv")
var furry_video = load("res://Sprites/Video/Furry.ogv")
var blue_furry = load("res://Sprites/Video/ФУРИ-СИНЕ-ЗЕЛЕНЫЙ.ogv")
var slovo_pacana = load("res://Sprites/Video/СЛОВО-ПАЦАНА.ogv")
var radion = load("res://Sprites/Video/РАДИОН.ogv")
var hot_furry = load("res://Sprites/Video/ГАРЯЧЫЙ-ФУРИ.ogv")
var basketball = load("res://Sprites/Video/БАСКЕТБОЛЬЧИК.ogv")
var scp = load("res://Sprites/Video/SCP.ogv")

var video = [furry_video, imba_video, blue_furry, slovo_pacana,
radion, hot_furry, basketball, scp 
]
var current_video: int = 0

func _ready() -> void:
	current_video = randi_range(0, len(video) - 1)
	$VideoStreamPlayer.stream = video[current_video]
	$VideoStreamPlayer.play()
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)

	Globals.player_pos = Vector2(1075, -674)
	$HBoxContainer/Item/BG/Button.text = "{0}$".format([Globals.dakimakura_price])
	$HBoxContainer/Item2/BG/Button2.text = "{0}$".format([Globals.estrogenator_price])
	$HBoxContainer/Item3/BG/Button3.text = "{0}$".format([Globals.kabachok_price])
	$HBoxContainer/Item4/BG/Button4.text = "{0}$".format([Globals.energy_drink_price])
	
	#if Globals.player_damage >= 20:
		#$HBoxContainer/Item5.queue_free()
		
	if Globals.player_damage >= 18:
		$HBoxContainer/Item2.queue_free()
		
	if Globals.player_shoot_speed <= 0.22:
		$HBoxContainer/Item3.queue_free()
		
	if Globals.player_speed > 500:
		$HBoxContainer/Item4.queue_free()
	
func _process(_delta: float) -> void:
	$Label.text = "Furry Dollars: " + str(Globals.money) + "$"

func _on_button_button_down() -> void:
	if Globals.money - Globals.dakimakura_price >= 0:
		Globals.money -= Globals.dakimakura_price
		Globals.dakimakura_count += 1
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer2.play()

func _on_button_2_button_down() -> void:
	if Globals.money - Globals.estrogenator_price >= 0:
		Globals.money -= Globals.estrogenator_price
		Globals.player_damage += 8
		$AudioStreamPlayer.play()
		$HBoxContainer/Item2.queue_free()
	else:
		$AudioStreamPlayer2.play()	

func _on_button_3_button_down() -> void:
	if Globals.money - Globals.kabachok_price >= 0:
		Globals.money -= Globals.kabachok_price
		Globals.player_speed += 20
		Globals.player_shoot_speed -= 0.08
		$AudioStreamPlayer.play()
		$HBoxContainer/Item3.queue_free()
	else:
		$AudioStreamPlayer2.play()
		
func _on_button_4_button_down() -> void:
	if Globals.money - Globals.energy_drink_price >= 0:
		Globals.money -= Globals.energy_drink_price
		Globals.player_speed += 155
		Globals.player_shoot_speed -= 0.02
		$AudioStreamPlayer.play()
		$HBoxContainer/Item4.queue_free()
	else:
		$AudioStreamPlayer2.play()

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")
	
func _on_video_stream_player_finished() -> void:
	current_video += 1
	if current_video == len(video):
		current_video = 0
	$VideoStreamPlayer.stream = video[current_video]
	$VideoStreamPlayer.play()

func _on_button_next_pressed() -> void:
	current_video += 1
	if current_video == len(video):
		current_video = 0
	$VideoStreamPlayer.stream = video[current_video]
	$VideoStreamPlayer.play()

#func _on_button_5_pressed() -> void:
	#if Globals.money - Globals.estrogenator_5000_price >= 0:
		#Globals.money -= Globals.estrogenator_5000_price
		#Globals.player_damage += 10
		#$AudioStreamPlayer.play()
		#$HBoxContainer/Item3.queue_free()
	#else:
		#$AudioStreamPlayer2.play()
