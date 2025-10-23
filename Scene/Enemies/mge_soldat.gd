extends "res://Scene/Enemies/base_enemy.gd"

func die():
	died = true	
	$AnimationPlayer.play("new_animation")
	if die_sound.playing:
		return 
	die_sound.play()
	await $AnimationPlayer.animation_finished
	queue_free()
