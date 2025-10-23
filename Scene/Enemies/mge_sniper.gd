extends BaseEnemie

var shoot_radius = 500
var in_attack = false

func _ready() -> void:
	add_to_group("Enemies")

func chase():
	var direction = Globals.player_pos - position
	if direction.length() <= shoot_radius or in_attack:
		state = ATTACK
		velocity = Vector2.ZERO
	else:
		velocity = direction.normalized() * speed
		
func attack():
	if not in_attack:
		in_attack = true
		await get_tree().create_timer(4).timeout
		in_attack = false
		state = CHASE
