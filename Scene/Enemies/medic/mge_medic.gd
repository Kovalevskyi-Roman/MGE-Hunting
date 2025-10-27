extends BaseEnemie

var shoot_radius = 390

func _physics_process(_delta: float) -> void:
	state = CHASE
	var direction = (Globals.enemy_pos - self.position).normalized()
	rotation = direction.angle()
	$Sprite2D2.flip_h = abs($Sprite2D2.rotation) > PI / 2
	$Sprite2D2.flip_v = $Sprite2D2.flip_h 
	move_and_slide()
	
func chase():
	var direction = (Globals.enemy_pos - self.position).normalized()
	if direction.length() <= shoot_radius:
		state = ATTACK
	else:
		velocity = direction * speed


	
		
