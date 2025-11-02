extends Control

func _ready() -> void:
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)

	Globals.player_pos = Vector2(1075, -674)
	$HBoxContainer/Item/BG/Button.text = "{0}$".format([Globals.dakimakura_price])
	$HBoxContainer/Item2/BG/Button2.text = "{0}$".format([Globals.estrogenator_price])
	$HBoxContainer/Item3/BG/Button3.text = "{0}$".format([Globals.kabachok_price])
	$HBoxContainer/Item4/BG/Button4.text = "{0}$".format([Globals.energy_drink_price])
	
	if Globals.player_damage == 20:
		$HBoxContainer/Item2.queue_free()
		
	if Globals.player_shoot_speed == 0.2:
		$HBoxContainer/Item3.queue_free()
		
	if Globals.player_speed > 500:
		$HBoxContainer/Item4.queue_free()
	
func _process(_delta: float) -> void:
	$Label.text = "Furry Dollars: " + str(Globals.money) + "$"

func _on_button_button_down() -> void:
	if Globals.money - Globals.dakimakura_price >= 0:
		Globals.money -= Globals.dakimakura_price
		Globals.dakimakura_count += 1

func _on_button_2_button_down() -> void:
	if Globals.money - Globals.estrogenator_price >= 0:
		Globals.money -= Globals.estrogenator_price
		Globals.player_damage = 20
		$HBoxContainer/Item2.queue_free()

func _on_button_3_button_down() -> void:
	if Globals.money - Globals.kabachok_price >= 0:
		Globals.money -= Globals.kabachok_price
		Globals.player_speed += 20
		Globals.player_shoot_speed = 0.2
		$HBoxContainer/Item3.queue_free()

func _on_button_4_button_down() -> void:
	if Globals.money - Globals.energy_drink_price >= 0:
		Globals.money -= Globals.energy_drink_price
		Globals.player_speed += 380
		$HBoxContainer/Item4.queue_free()

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")
