extends CharacterBody2D
class_name EnemieBullet

var speed = 16

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(marker_pos):
	var direction: Vector2 = (Globals.player_pos - marker_pos).normalized()
	velocity = direction * speed
	rotation = direction.angle() - PI / 2
	
	
#оно ведь не используется	
func create_angle_bullet(angle: int):
	velocity = Vector2.from_angle(deg_to_rad(angle)) * speed
	rotation = deg_to_rad(angle - 90)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp = 0
	queue_free()
