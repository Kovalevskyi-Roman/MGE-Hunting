extends CharacterBody2D
class_name BaseEnemie

var speed = 320
@onready var die_sound = $AudioStreamPlayer2D
var died = false

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
			ATTACK:
				attack()

func _ready() -> void:
	add_to_group("Enemies")

func _physics_process(_delta: float) -> void:
	state = CHASE
	move_and_slide()

func chase():
	if died != true:
		var direction = (Globals.player_pos - self.position).normalized()
		velocity = speed * direction	
		if direction.x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		velocity = Vector2.ZERO

func die():
	died = true	
	if die_sound.playing:
		return 
	die_sound.play()
	await die_sound.finished
	queue_free()
	

func attack():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and died != true:
		body.hp -= 1
