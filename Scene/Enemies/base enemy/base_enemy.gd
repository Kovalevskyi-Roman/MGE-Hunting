extends CharacterBody2D
class_name BaseEnemie

const PROTEIN = preload("res://Scene/Лут из врагов/Protein/protein.tscn")
const TESTESTERONE = preload("res://Scene/Лут из врагов/Testesterone/testesterone.tscn")

var type_drop = [PROTEIN, TESTESTERONE]

@export var speed = 290
@onready var die_sound = $AudioStreamPlayer2D
var died = false
var armor_active: bool = false

enum {
	CHASE,
	ATTACK,
	DIE,
	KAMIKAZE
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
	$Area2D.add_to_group("Enemies")

func _physics_process(_delta: float) -> void:
	armor()
	state = CHASE
	move_and_slide()
	Globals.enemy_pos = self.position
	Globals.global_enemy_pos = self.global_position
	
func armor():
	if Globals.current_wave >= 5:
		armor_active = true
		$Helmet.visible = true
		$Chestplate.visible = true	

func chase():
	if died != true:
		var direction = (Globals.player_pos - self.position).normalized()
		velocity = speed * direction	
	else:
		velocity = Vector2.ZERO

func die():
	died = true	
	$AnimationPlayer.play("die")
	if die_sound.playing:
		return 
	die_sound.play()
	await $AnimationPlayer.animation_finished
	drop_spawn()
	queue_free()

func drop_spawn():
	var drop = type_drop.pick_random().instantiate()
	drop.position = self.position
	get_tree().current_scene.add_child(drop)
	
func attack():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and died != true:
		body.hp = 0
