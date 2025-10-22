extends CharacterBody2D

var speed = 230

enum {
	CHASE,
	ATTACK,
	DIE
}

@export var hp: int = 40:
	set(value):
		hp = value
		if hp <= 0:
			state = DIE

var state: int = 0:
	set(value):
		state = value
		match state:
			CHASE:
				chase()
			DIE:
				die()

func _ready() -> void:
	add_to_group("Enemies")

func _physics_process(_delta: float) -> void:
	state = CHASE
	move_and_slide()

func chase():
	var direction = (Globals.player_pos - self.position).normalized()
	velocity = speed * direction	
	if direction.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func die():
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp -= 1
