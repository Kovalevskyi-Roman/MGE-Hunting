extends CharacterBody2D
class_name Boss

const TRAIN = preload("res://Scene/Enemies/train/mge_train.tscn")
const BULLET = preload("res://Scene/Bullets/Sniper Bullets/enemie_bullet.tscn")

var move_speed: int = 320
var hp: int = 550:
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
	$TrainTimer.stop()
	
	if not died:
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
		died = true
		await $AudioStreamPlayer.finished
		var train_top: MGETrain = TRAIN.instantiate()
		var train_bottom: MGETrain = TRAIN.instantiate()
		var train_left: MGETrain = TRAIN.instantiate()
		var train_right: MGETrain = TRAIN.instantiate()
		
		train_top.get_node("ColorRect").visible = false
		train_bottom.get_node("ColorRect").visible = false
		train_left.get_node("ColorRect").visible = false
		train_right.get_node("ColorRect").visible = false

		const dist = 3000
		const speed = 1000
		train_top.global_position = Globals.global_player_pos - Vector2(0, dist)
		train_bottom.global_position = Globals.global_player_pos + Vector2(0, dist)
		train_left.global_position = Globals.global_player_pos - Vector2(dist, 0)
		train_right.global_position = Globals.global_player_pos + Vector2(dist, 0)
		
		train_top.scale = Vector2(3, 3)
		train_bottom.scale = Vector2(3, 3)
		train_left.scale = Vector2(3, 3)
		train_right.scale = Vector2(3, 3)
		
		train_top.speed = speed
		train_bottom.speed = speed
		train_left.speed = speed
		train_right.speed = speed

		train_top.move_direction(Vector2(0, 1))
		train_bottom.move_direction(Vector2(0, -1))
		train_left.move_direction(Vector2(1, 0))
		train_right.move_direction(Vector2(-1, 0))
		
		for e in $"../".get_children():
			if e.is_in_group("Boss"):
				continue
			e.queue_free()
		
		$"../".add_child(train_top)
		$"../".add_child(train_bottom)
		$"../".add_child(train_left)
		$"../".add_child(train_right)

func _physics_process(_delta: float) -> void:
	Globals.enemy_pos = self.position
	Globals.global_enemy_pos = self.global_position

	max_train_count = ceil(1000.0 / hp)
	if max_train_count > 12:
		max_train_count = 12
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
