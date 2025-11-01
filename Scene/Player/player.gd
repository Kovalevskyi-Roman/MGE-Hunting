extends CharacterBody2D

const BULLET = preload("res://Scene/Bullets/Players Bullets/bullet.tscn")
const DAKIMAKURA = preload("res://Scene/Bullets/dakimakura/dakimakura.tscn")

enum {
	MOVE,
	DIE
}

var state = MOVE
var speed = Globals.player_speed

var hp: int = 10:
	set(value):
		hp = value
		if hp <= 0:
			state = DIE	

func _ready() -> void:
	$Camera2D.zoom.x = get_window().size.x / 1920.0
	$Camera2D.zoom.y = $Camera2D.zoom.x
	state = MOVE

func _physics_process(_delta: float) -> void:
	match state:
		MOVE:
			move_player()
		DIE:
			die_player()
	
	Globals.player_pos = self.position
	Globals.global_player_pos = self.global_position
	
func move_player():
	rotate_player()
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if Input.is_action_just_pressed("throw_dakimakura") and Globals.dakimakura_count > 0:
		throw_dakimakura()
		
	move_and_slide()
		
func rotate_player():
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= 2.7
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += 2.7
		
func die_player():
	queue_free()
	
func throw_dakimakura():
	var dakimakura: Dakimakura = DAKIMAKURA.instantiate()
	dakimakura.create(rotation)
	get_tree().current_scene.add_child(dakimakura)
	
	Globals.dakimakura_count -= 1
	
func shot():
	var bullet = BULLET.instantiate()
	bullet.create_bullet(rotation + PI/2)
	bullet.global_position = $Marker2D.global_position
	get_tree().current_scene.add_child(bullet)

func _on_shot_timer_timeout() -> void:
	shot()
