extends BaseEnemie

const BULLET = preload("res://Scene/Bullets/Sniper Bullets/enemie_bullet.tscn")
const CENSURED_BULLET = preload("res://CensuredVersion/censured_bullet.tscn")

var shoot_radius = 520
var in_attack = false
	
func _physics_process(_delta: float) -> void:
	var direction: Vector2 = (Globals.global_player_pos - $Sprite2D2.global_position).normalized()
	$Sprite2D2.rotation = direction.angle()
	$Sprite2D2.flip_h = abs($Sprite2D2.rotation) > PI / 2
	$Sprite2D2.flip_v = $Sprite2D2.flip_h
	super(_delta)

func chase():
	if died != true:
		var direction = Globals.player_pos - position
		if direction.length() <= shoot_radius or in_attack:
			state = ATTACK
			velocity = Vector2.ZERO
		else:
			velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
				
func attack():
	if not in_attack and died != true:
		in_attack = true
		var bullet: EnemieBullet = BULLET.instantiate()
		bullet.create_bullet($Sprite2D2/Marker2D.global_position)
		bullet.global_position = $Sprite2D2/Marker2D.global_position
		get_tree().current_scene.add_child(bullet)
		await get_tree().create_timer(1).timeout
		in_attack = false
		state = CHASE
