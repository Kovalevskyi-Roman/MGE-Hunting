extends Node

var player_pos: Vector2 = Vector2(1075, -322.0)
var global_player_pos: Vector2
var player_damage: int = 10
var player_speed: int = 470
var player_shoot_speed: float = 0.29
var dakimakura_count: int = 0
var number_of_enemies: int = 0
var enemy_pos: Vector2
var global_enemy_pos: Vector2
var current_wave: int

var dakimakura_price: int = 4
var estrogenator_price: int = 30
var kabachok_price: int = 25
var energy_drink_price: int = 40

var money: int = 0
var global_money: int = 0

var skins = []
var current_skin: int = 0

func _ready() -> void:
	var file = FileAccess.open("res://Sprites/Skins/skins.json", FileAccess.READ)

	if file:
		var content = file.get_as_text()
		file.close()

		var result = JSON.parse_string(content)
		for json_skin in result:
			var texture_path = str("res://Sprites/Skins/" + json_skin.get("texture"))
			var texture = load(texture_path)
			
			skins.append(
				{
					"name": json_skin.get("name"),
					"texture": texture,
					"price": json_skin.get("price")
				}
			)
