extends CharacterBody2D
class_name Boss

var move_speed: int = 100
var hp: int = 1000:
	set(value):
		if value <= 0:
			state = states.DIE
		hp = value

enum states {
	IDLE,
	CHASE,
	ATTACK,
	DIE
}

var state: states = states.IDLE

func idle() -> void:
	velocity = Vector2.ZERO
	await get_tree().create_timer(4).timeout
	state = states.CHASE

func chase() -> void:
	var direction: Vector2 = Globals.global_player_pos - global_position
	velocity = direction.normalized() * move_speed

	await get_tree().create_timer(randi() % 10 + 1).timeout
	state = states.IDLE

func attack() -> void:
	pass

func die() -> void:
	queue_free()

func _ready() -> void:
	state = states.IDLE

func _physics_process(_delta: float) -> void:
	match state:
		states.IDLE:
			idle()
		states.CHASE:
			chase()
		states.ATTACK:
			attack()
		states.DIE:
			die()

	move_and_slide()
