extends "res://Scene/Enemies/base_enemy.gd"

func die():
	died = true	
	$AnimationPlayer.play("new_animation")
	if die_sound.playing:
		return 
	die_sound.play()
	await die_sound.finished
	queue_free()
