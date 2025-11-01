extends Control

func _ready() -> void:
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)

	Globals.player_pos = Vector2(1075, -674)
	$HBoxContainer/Item2/BG/Button.text = "Buy ({0}$)".format([Globals.dakimakura_price])
	
func _process(_delta: float) -> void:
	$Label.text = "Furry Dollars: " + str(Globals.money) + "$"

func _on_button_button_down() -> void:
	if Globals.money - Globals.dakimakura_price >= 0:
		Globals.money -= Globals.dakimakura_price
		Globals.dakimakura_count += 1

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")
