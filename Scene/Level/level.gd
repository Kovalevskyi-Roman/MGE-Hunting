extends Node2D

const BOSS = preload("res://Scene/Enemies/Boss/boss.tscn")
signal wave_start(is_wave_active: bool)

@onready var anim = $WaveMechanics/AnimationPlayer
var level_rect: Rect2 = Rect2(Vector2(-882, -505), Vector2(3956, 2810))

func _ready() -> void:
	$WaveMechanics/CanvasLayer.scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)
	$Player.position = Globals.player_pos

func _process(_delta: float) -> void:
	if $Enemies.get_child_count() or Globals.number_of_enemies > 0:
		emit_signal("wave_start", true)
	else:
		$"Music/tick-tock".stop()
		if $Music/Kiss_me.playing == false:
			$Music/Kiss_me.play()
		emit_signal("wave_start", false)
		$Button.visible = true

func next_wave():
	if level_rect.has_point(Globals.player_pos):
		if $Enemies.get_child_count() or Globals.number_of_enemies > 0:
			return
		$Music/Kiss_me.stop()		
		$"Music/tick-tock".play()
		Globals.current_wave += 1
		Globals.number_of_enemies = (Globals.current_wave * 4) + 1
		print(Globals.number_of_enemies)
		$WaveMechanics/CanvasLayer/CurrentWave.text = "WAVE " + str(Globals.current_wave)
		anim.play("new_animation")
		
		if Globals.current_wave == 8:
			Globals.number_of_enemies = 12
			var boss = BOSS.instantiate()
			$Enemies.add_child(boss)
	
func _on_button_button_down() -> void:
	$Button.visible = false
	$Button/AudioStreamPlayer.play()
	next_wave()
