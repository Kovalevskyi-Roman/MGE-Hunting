extends CharacterBody2D

var speed = 23
var damage = 10

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(rotation_player):
	velocity = Vector2.from_angle(rotation_player) * speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent.died == true:
		return
	if area_parent.is_in_group("Boss") == false:
		if area_parent.armor_active == true:
			damage = damage - 5

	if area_parent.is_in_group("Boss"):
		area_parent.hp -= damage / 2.0
	elif area_parent.is_in_group("Enemies"):
		area_parent.hp -= damage
	else:
		return
		
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		return
	queue_free()
