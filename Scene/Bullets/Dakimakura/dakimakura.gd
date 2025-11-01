extends CharacterBody2D
class_name Dakimakura

var friction: float = 0.02
var speed: int = 20
var damage: int = 2

var colided_with: Array = Array()

func create(player_rotation) -> void:
	rotation = player_rotation + PI / 2
	global_position = Globals.global_player_pos
	velocity = Vector2.from_angle(player_rotation + PI / 2) * speed

	$Sprite2D.flip_v = rotation > PI / 2

func _physics_process(_delta: float) -> void:
	velocity = lerp(velocity, Vector2.ZERO, friction)

	for body in colided_with:
		body.position += velocity

	move_and_collide(velocity)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	if body.is_in_group("Enemies") or body.is_in_group("Boss"):
		if not colided_with.has(body):
			colided_with.append(body)
			body.hp -= damage
			velocity = lerp(velocity, Vector2.ZERO, friction)
		return

	body.queue_free()
	
func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_area_2d_area_exited(area: Area2D) -> void:
	var body = area.get_parent()
	if body.is_in_group("Enemies") or body.is_in_group("Boss"):
		if colided_with.has(body):
			colided_with.erase(body)
