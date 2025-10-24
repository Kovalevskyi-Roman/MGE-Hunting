extends CharacterBody2D
class_name EnemieBullet

var speed = 10

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(enemie_pos):
	var direction: Vector2 = (Globals.player_pos - enemie_pos).normalized()
	velocity = direction * speed
	rotation = direction.angle() - PI / 2

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp = 0
		queue_free()
