extends Control

var selected: int = 0

func _ready() -> void:
	if Globals.current_wave == 3 or Globals.current_wave == 6:
		Globals.current_wave += 1

	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)
	_update_shop()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")

func _update_shop() -> void:
	$Panel/Money.text = "Money: " + str(Globals.global_money) + "$"
	
	$Panel/Price.text = str(int(Globals.skins[selected].get("price"))) + "$"
	$Panel/SkinTitle.text = Globals.skins[selected].get("name")
	$Panel/Skin.texture = Globals.skins[selected].get("texture")
	
	if int(Globals.skins[selected].get("price")):
		$Panel/Skin.texture = load("res://icon.svg")

func _on_buy_button_pressed() -> void:
	if Globals.global_money - Globals.skins[selected].get("price") >= 0:
		Globals.global_money -= Globals.skins[selected].get("price")
		Globals.skins[selected].set("price", 0)
		Globals.current_skin = selected

	_update_shop()

func _on_next_button_pressed() -> void:
	selected += 1
	if selected == len(Globals.skins):
		selected = 0
		
	_update_shop()

func _on_previous_button_pressed() -> void:
	selected -= 1
	if selected < 0:
		selected = len(Globals.skins) - 1
		
	_update_shop()
