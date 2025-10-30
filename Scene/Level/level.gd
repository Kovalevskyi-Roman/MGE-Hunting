extends Node2D


const BOSS = preload("res://Scene/Enemies/Boss/boss.tscn")
signal wave_start(is_wave_active: bool)

var current_wave: int = 0
@onready var anim = $WaveMechanics/AnimationPlayer

var enemies: int = 0:
	set(value):
		enemies = value
		Globals.number_of_enemies = enemies

func _ready() -> void:
	$WaveMechanics/CanvasLayer.scale = Vector2(get_window().size.x / 1920.0, get_window().size.x / 1080.0)

func _process(_delta: float) -> void:
	if $Enemies.get_child_count() or Globals.number_of_enemies > 0:
		emit_signal("wave_start", true)
	else:
		emit_signal("wave_start", false)	
	
	if Input.is_action_just_pressed("TestSpawnWave"):
		next_wave()

func next_wave():	
	if $Enemies.get_child_count():
		return	
	enemies += 5
	current_wave += 1
	$WaveMechanics/CanvasLayer/CurrentWave.text = "WAVE " + str(current_wave)
	anim.play("new_animation")
	if current_wave == 8:
		enemies = 20
		var boss = BOSS.instantiate()
		$Enemies.add_child(boss)
		
	
	
	
