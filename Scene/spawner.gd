extends Node2D

const ENEMY = preload("res://Scene/Enemies/MGE Soldat.tscn")

func _on_spawn_timer_timeout() -> void:
	var enemy = ENEMY.instantiate()
	var x = randf_range(1.5, 2)
	var y = x
	enemy.scale = Vector2(x, y)
	$"../Enemies".add_child(enemy)
