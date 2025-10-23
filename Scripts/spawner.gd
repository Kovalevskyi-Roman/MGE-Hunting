extends Node2D

const ENEMY = preload("res://Scene/Enemies/MGE Soldat.tscn")

func _on_spawn_timer_timeout() -> void:
	var enemy = ENEMY.instantiate()
	var enemy_scale = randf_range(1.5, 2)
	var spawn_position = self.position - Vector2(randi_range(-200, 200), randi_range(-200, 200))
	enemy.scale = Vector2(enemy_scale, enemy_scale)
	enemy.position = spawn_position
	$"../Enemies".add_child(enemy)
