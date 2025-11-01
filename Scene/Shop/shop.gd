extends Control

func _ready() -> void:
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)
	
	$HBoxContainer/Item/Button.text = "Buy ({0})".format([Globals.dakimakura_price])
	
	print($HBoxContainer.get_property_list())

func _on_button_button_down() -> void:
	Globals.dakimakura_count += 1

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")
