extends BaseEnemie
class_name MGETrain

var go_to_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	hp = 1000
	speed = 900

func move_direction(direction: Vector2) -> void:
	rotation = direction.angle()
	velocity = direction.normalized() * speed
	
	if rotation >= PI:
		$AnimatedSprite2D.flip_v = true
		$AnimatedSprite2D.offset.y = 97

func move_to_point(point_1: Vector2, point_2: Vector2) -> void:
	var direction = (point_2 - point_1)

	if point_2 == Vector2.ZERO:
		direction = (go_to_position - point_1)
	move_direction(direction)

func _physics_process(_delta: float) -> void:	
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp = 0

func _on_timer_timeout() -> void:
	queue_free()
