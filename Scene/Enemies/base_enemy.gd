extends CharacterBody2D

var speed = 250
@onready var anim = $AnimatedSprite2D

enum {
	CHASE,
	ATTACK,
	DIE
}

var hp: int = 40:
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
	
func die():
	anim.play("death")
	await anim.animation_finished
	queue_free()
