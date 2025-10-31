extends Node2D

const BOSS = preload("res://Scene/Enemies/Boss/boss.tscn")
signal wave_start(is_wave_active: bool)

@onready var anim = $WaveMechanics/AnimationPlayer
var level_rect: Rect2 = Rect2(Vector2(-882, -505), Vector2(3956, 2810))

var enemies: int = 0:
	set(value):
		enemies = value
		Globals.number_of_enemies = enemies

func _ready() -> void:
	$WaveMechanics/CanvasLayer.scale = Vector2(get_window().size.x / 1920.0, get_window().size.x / 1920.0)

func _process(_delta: float) -> void:
	if $Enemies.get_child_count() or Globals.number_of_enemies > 0:
		emit_signal("wave_start", true)
	else:
		emit_signal("wave_start", false)	
	
	if Input.is_action_just_pressed("TestSpawnWave"):
		next_wave()

func next_wave():
	if level_rect.has_point(Globals.player_pos):
		if $Enemies.get_child_count() or Globals.number_of_enemies > 0:
			return	
		Globals.current_wave += 1
		enemies += 5 + Globals.current_wave
		$WaveMechanics/CanvasLayer/CurrentWave.text = "WAVE " + str(Globals.current_wave)
		anim.play("new_animation")
		if Globals.current_wave == 8:
			enemies = 0
			var boss = BOSS.instantiate()
			$Enemies.add_child(boss)
		
	
	
	
