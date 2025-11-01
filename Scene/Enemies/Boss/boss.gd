extends CharacterBody2D
class_name Boss

const TRAIN = preload("res://Scene/Enemies/train/mge_train.tscn")
const BULLET = preload("res://Scene/Bullets/Sniper Bullets/enemie_bullet.tscn")

var move_speed: int = 250
var hp: int = 500:
	set(value):
		if value <= 0:
			state = states.DIE
		hp = value

var died = false
var use_horizontal_trains = true
var use_vertical_trains = true
var max_train_count: int = 1
var idle_time = 1.5
var bullet_count = 18

var in_shoot = false

enum states {
	CHASE,
	SHOOT,
	DIE
}

var state: states = states.CHASE

func chase() -> void:
	var direction: Vector2 = Globals.global_player_pos - global_position
	velocity = direction.normalized() * move_speed

func shoot() -> void:
	velocity = Vector2.ZERO
	if in_shoot:
		return
	in_shoot = true
	for i in range(0, 360, int(360.0 / bullet_count)):
		var bullet = BULLET.instantiate()
		bullet.create_angle_bullet(i)
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		
	await get_tree().create_timer(idle_time).timeout
	state = states.CHASE
	in_shoot = false

func double_shoot() -> void:
	velocity = Vector2.ZERO
	if in_shoot:
		return
	in_shoot = true
	for i in range(0, 360, int(360.0 / bullet_count)):
		var bullet = BULLET.instantiate()
		bullet.create_angle_bullet(i)
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)

	velocity = Vector2.ZERO
	await get_tree().create_timer(0.6).timeout
	for i in range(0, 360, int(360.0 / bullet_count)):
		var bullet = BULLET.instantiate()
		bullet.create_angle_bullet(i + int(360.0 / bullet_count) * 1.45)
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		
	await get_tree().create_timer(idle_time).timeout
	state = states.CHASE
	in_shoot = false

func train_horizontal() -> void:
	var count = randi() % max_train_count + 1
	for i in range(0, count):
		var path: PathFollow2D = [
			$"../../TrainSpawn/HorizontalTop/PathFollow2D",
			$"../../TrainSpawn/HorizontalBottom/PathFollow2D"
		].pick_random()
		var train: MGETrain = TRAIN.instantiate()
		path.progress_ratio = randf()
		train.global_position = path.global_position
		if path.get_parent().name == "HorizontalTop":
			train.go_to_position = Vector2(train.global_position.x, train.go_to_position.y + 1)
		elif path.get_parent().name == "HorizontalBottom":
			train.go_to_position = Vector2(train.global_position.x, train.go_to_position.y - 1)

		$"../".add_child(train)
		train.move_to_point(train.global_position, Vector2.ZERO)

func train_vertical() -> void:
	var count = randi() % max_train_count + 1
	for i in range(0, count):
		var path: PathFollow2D = [
			$"../../TrainSpawn/VerticalLeft/PathFollow2D",
			$"../../TrainSpawn/VerticalRight/PathFollow2D"
		].pick_random()
		var train: MGETrain = TRAIN.instantiate()
		path.progress_ratio = randf()
		train.global_position = path.global_position
		if path.get_parent().name == "VerticalLeft":
			train.go_to_position = Vector2(train.go_to_position.x + 1, train.global_position.y)
		elif path.get_parent().name == "VerticalRight":
			train.go_to_position = Vector2(train.go_to_position.x - 1, train.global_position.y)

		$"../".add_child(train)
		train.move_to_point(train.global_position, Vector2.ZERO)

func die() -> void:
	velocity = Vector2.ZERO
	$ShootTimer.stop()
	if not died:
		died = true
		for i in range(0, 360, int(360.0 / 300)):
			var bullet = BULLET.instantiate()
			bullet.create_angle_bullet(i)
			bullet.global_position = global_position
			get_tree().current_scene.add_child(bullet)
			
		$AudioStreamPlayer.play()

func _physics_process(_delta: float) -> void:
	Globals.enemy_pos = self.position
	Globals.global_enemy_pos = self.global_position

	max_train_count = ceil(1000.0 / hp)
	if max_train_count > 50:
		max_train_count = 50

	if died:
		state = states.DIE

	match state:
		states.CHASE:
			chase()
		states.SHOOT:
			if hp > 250:
				shoot()
			else:
				double_shoot()
		states.DIE:
			die()

	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	if died:
		return
	state = states.SHOOT

func _on_train_timer_timeout() -> void:
	if died:
		return
	if use_horizontal_trains:
		train_horizontal()
	if use_vertical_trains:
		train_vertical()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp = 0
