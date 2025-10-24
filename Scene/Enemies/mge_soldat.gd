extends "res://Scene/Enemies/base_enemy.gd"

func die():
	died = true	
	$AnimationPlayer.play("die")
	if die_sound.playing:
		return 
	die_sound.play()
	await $AnimationPlayer.animation_finished
	queue_free()
	
