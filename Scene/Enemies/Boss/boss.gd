extends CharacterBody2D
class_name Boss

const BULLET = preload("res://Scene/Bullets/Sniper Bullets/enemie_bullet.tscn")

var move_speed: int = 250
var hp: int = 150:
	set(value):
		if value <= 0:
			state = states.DIE
		hp = value
var died = false

enum states {
	IDLE,
	CHASE,
	ATTACK,
	SHOOT,
	DIE
}

var state: states = states.IDLE

func idle() -> void:
	velocity = Vector2.ZERO
	await get_tree().create_timer(1).timeout
	state = states.CHASE

func chase() -> void:
	var direction: Vector2 = Globals.global_player_pos - global_position
	velocity = direction.normalized() * move_speed

func shoot() -> void:
	for i in range(0, 360, int(360.0 / 18)):
		var bullet = BULLET.instantiate()
		bullet.create_angle_bullet(i)
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
	
	state = states.IDLE

func attack() -> void:
	pass

func die() -> void:
	velocity = Vector2.ZERO
	$ShootTimer.stop()
	if not died:
		died = true
		for i in range(0, 360, int(360.0 / 360)):
			var bullet = BULLET.instantiate()
			bullet.create_angle_bullet(i)
			bullet.global_position = global_position
			get_tree().current_scene.add_child(bullet)
			
		$AudioStreamPlayer.play()

func _ready() -> void:
	state = states.IDLE

func _physics_process(_delta: float) -> void:
	Globals.enemy_pos = self.position
	Globals.global_enemy_pos = self.global_position
	
	if died:
		state = states.DIE

	match state:
		states.IDLE:
			idle()
		states.CHASE:
			chase()
		states.ATTACK:
			attack()
		states.SHOOT:
			shoot()
		states.DIE:
			die()
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	state = states.SHOOT
