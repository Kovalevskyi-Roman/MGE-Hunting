extends Node2D

var current_wave: int = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("TestSpawnWave"):
		Globals.number_of_enemies += 4
		current_wave += 1
