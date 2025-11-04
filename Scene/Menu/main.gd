extends Node2D

func _ready() -> void:
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)
	$AnimationPlayer_1.play("1")
	Globals.money = 0
	Globals.dakimakura_count = 0
	if Globals.current_wave >= 4:
		if Globals.current_wave >= 7:
			Globals.current_wave = 6
			Globals.number_of_enemies += 15
			Globals.money = 12
		else:
			Globals.current_wave = 3
			Globals.money = 4
	else:
		Globals.current_wave = 0
		
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")

func _on_settings_button_pressed() -> void:
	pass
