extends CharacterBody2D

var speed = 22

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(rotation_player):
	velocity = Vector2.from_angle(rotation_player) * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.hp -= 10
	queue_free()
