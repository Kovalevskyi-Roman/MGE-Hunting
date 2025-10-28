extends CharacterBody2D

var speed = 21

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(marker_pos):
	var direction: Vector2 = (Globals.enemy_pos - marker_pos).normalized()
	velocity = direction * speed
	rotation = direction.angle() - PI / 2

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area.is_in_group("Enemies") and area_parent.hp <= 70:
		area_parent.hp += 10
	queue_free()
