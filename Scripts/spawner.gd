extends Node2D

const ENEMY_SOLDER= preload("res://Scene/Enemies/MGE Soldat.tscn")
const ENEMY_SNIPER = preload("res://CensuredVersion/censured_sniper.tscn")

var type_enemy = [ENEMY_SNIPER, ENEMY_SOLDER]

@export var camera_path : NodePath
@onready var cam = get_node(camera_path)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy(Globals.number_of_enemies)
	
func spawn_enemy(_number_of_enemies):
	if cam == null:
		return

	var enemy = (type_enemy.pick_random()).instantiate()
	var camera_pos = cam.global_position
	var view_size = get_viewport().get_visible_rect().size
	var half = view_size * 0.5
	var pos = camera_pos + Vector2(randf_range(-half.x * 1.5, half.x * 1.5), randf_range(-half.y * 1.5, half.y * 1.5))
	var level_rect: Rect2 = Rect2(Vector2(-882, -505), Vector2(3956, 2810))

	if Rect2(camera_pos - half, view_size).has_point(pos):
		pos += sign(pos - camera_pos) * half		
		
	if not level_rect.has_point(pos):
		enemy.queue_free()
		Globals.number_of_enemies += 1
		
	#pos += sign(pos - camera_pos) * half
	#pos.x = clamp(pos.x, level_rect.position.x, level_rect.position.x + level_rect.size.x)
	#pos.y = clamp(pos.y, level_rect.position.y, level_rect.position.y + level_rect.size.y)	
	
	if Globals.number_of_enemies > 0:
		Globals.number_of_enemies -= 1
		#var enemy_scale = randf_range(1.3, 1.7)
		#var spawn_position = self.position - Vector2(randi_range(-200, 200), randi_range(-200, 200))
		#enemy.scale = Vector2(enemy_scale, enemy_scale)
		enemy.position = pos
		$"../../Enemies".add_child(enemy)
