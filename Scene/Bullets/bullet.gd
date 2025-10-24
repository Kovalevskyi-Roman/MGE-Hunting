extends CharacterBody2D

var speed = 23

func _physics_process(_delta: float) -> void:
	move_and_collide(velocity)
	
func create_bullet(rotation_player):
	velocity = Vector2.from_angle(rotation_player) * speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent.died == true:
		return
	if area_parent.is_in_group("Enemies"):
		area_parent.hp -= 10
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
