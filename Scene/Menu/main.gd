extends Node2D

#@onready var spectrum: AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(
	#AudioServer.get_bus_index("Music"), 0
#)

func _ready() -> void:
	$AnimationPlayer_1.play("1")

#func _process(_delta) -> void:
	#if spectrum:
		#var energy: float = spectrum.get_magnitude_for_frequency_range(1, 500).length()
		#var scale_factor: float = lerp($PlayButton.scale.x, 0.8 + energy, 0.4)
		## buttons
		#$PlayButton.scale = Vector2(scale_factor, scale_factor)
		#$SettingsButton.scale = Vector2(scale_factor, scale_factor)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level/level.tscn")

func _on_settings_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/settings.tscn")
	pass
