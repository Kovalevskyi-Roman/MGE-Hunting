extends BaseEnemie

const BULLET = preload("res://Scene/Bullets/Medic Bullets/medic_bullet.tscn")

var shoot_radius = 390
var in_attack = false

func _physics_process(_delta: float) -> void:
	state = CHASE
	weapon_rotation()
	move_and_slide()
	
func chase():
	if died != true:
		var direction = Globals.enemy_pos - self.position
		if direction.length() <= shoot_radius or in_attack == true:
			state = ATTACK
			velocity = Vector2.ZERO
		else:
			velocity = direction.normalized() * speed
		#if direction.x < 0:
			#$Sprite2D.flip_h = true
		#else:
			#$Sprite2D.flip_h = false
	else:	
		velocity = Vector2.ZERO

func attack():
	if in_attack == false:
		in_attack = true
		var bullet = BULLET.instantiate()
		bullet.create_bullet($Sprite2D2/Marker2D.global_position)
		bullet.global_position = $Sprite2D2/Marker2D.global_position
		get_tree().current_scene.add_child(bullet)
		await get_tree().create_timer(1).timeout
		in_attack = false
		state = CHASE
		
func weapon_rotation():
	var direction: Vector2 = (Globals.global_enemy_pos - $Sprite2D2.global_position).normalized()
	$Sprite2D2.rotation = direction.angle() + deg_to_rad(135)
	#$Sprite2D2.flip_h = abs($Sprite2D2.rotation) > PI / 2
	#$Sprite2D2.flip_v = $Sprite2D2.flip_h 
	
func die():
	died = true	
	$AnimationPlayer.play("die")
	if die_sound.playing:
		return 
	die_sound.play()
	await $AnimationPlayer.animation_finished
	queue_free()

	
		
