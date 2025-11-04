extends Node2D


const ENEMY_SOLDER= preload("res://Scene/Enemies/solder/MGE Soldat.tscn")
const ENEMY_SNIPER = preload("res://Scene/Enemies/sniper/MGE Sniper.tscn")
const ENEMY_MEDIC = preload("res://Scene/Enemies/medic/MGE medic.tscn")
const ENEMY_DEMOMAN = preload("res://Scene/Enemies/demoman/demoman.tscn")

var type_enemy = [ENEMY_SOLDER, ENEMY_SNIPER, ENEMY_SOLDER, ENEMY_SOLDER, ENEMY_SNIPER, ENEMY_DEMOMAN, ENEMY_DEMOMAN, ENEMY_MEDIC]

@export var camera_path : NodePath
@onready var cam: Camera2D = get_node(camera_path)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy(Globals.number_of_enemies)
	
func spawn_enemy(_number_of_enemies):
	if cam == null:
		return

	var enemy = type_enemy.pick_random().instantiate()
	var camera_pos = cam.global_position
	var view_size = get_viewport().get_visible_rect().size / cam.zoom
	var half = view_size * 0.5
	var pos = camera_pos + Vector2(randf_range(-half.x * 1.7, half.x * 1.7), randf_range(-half.y * 1.6, half.y * 1.6))
	var level_rect: Rect2 = Rect2(Vector2(-882, -505), Vector2(3956, 2810))

	if Rect2(camera_pos - half, view_size).has_point(pos):
		pos += sign(pos - camera_pos) * half		
		
	if not level_rect.has_point(pos):
		enemy.queue_free()
		Globals.number_of_enemies += 1
	
	if Globals.number_of_enemies > 0:
		Globals.number_of_enemies -= 1
		#var enemy_scale = randf_range(1.3, 1.7)
		#var spawn_position = self.position - Vector2(randi_range(-200, 200), randi_range(-200, 200))
		#enemy.scale = Vector2(enemy_scale, enemy_scale)
		enemy.position = pos
		$"../../Enemies".add_child(enemy)
