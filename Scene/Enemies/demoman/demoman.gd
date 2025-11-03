extends BaseEnemie

func chase():
	if died != true:
		if $AnimationPlayer.is_playing():
			state = ATTACK
			velocity = Vector2.ZERO
			return

		var direction = (Globals.player_pos - self.position)
		rotation = direction.angle() - PI/2
		velocity = direction.normalized() * speed
		
		if direction.length() <= 260:
			state = ATTACK
	else:
		velocity = Vector2.ZERO

func attack():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("attack")

	await $AnimationPlayer.animation_finished
	state = CHASE
	
func _on_weapon_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and died != true:
		body.hp = 0
