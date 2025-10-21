extends CharacterBody2D
class_name Boss

var move_speed: int = 100
var hp: int = 1000:
	set(value):
		if value <= 0:
			queue_free()
		hp = value
		
func _physics_process(_delta: float) -> void:
	var distance = (Globals.player_pos - global_position)
	if distance.length() >= 700:
		velocity += distance.normalized() * (move_speed / 4)
	else:
		velocity = distance.normalized() * move_speed
	
	move_and_slide()
