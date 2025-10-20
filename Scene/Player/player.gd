extends CharacterBody2D

const BULLET = preload("res://Scene/Bullets/bullet.tscn")

var speed = 300

func _physics_process(_delta: float) -> void:
	move_player()
	rotate_player()
	
	Globals.player_pos = self.position
	
func move_player():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed	
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed		
	
	move_and_slide()
		
func rotate_player():
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees += 2.7
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees -= 2.7
	
func shot():
	var _bullet = BULLET.instantiate()
	_bullet.create_bullet(rotation + PI/2)
	_bullet.global_position = $Marker2D.global_position
	get_tree().current_scene.add_child(_bullet)

func _on_shot_timer_timeout() -> void:
	shot()
