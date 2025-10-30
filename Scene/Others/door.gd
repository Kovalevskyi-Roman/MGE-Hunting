extends Node2D

func _on_level_wave_start(is_wave_active: bool) -> void:
	if is_wave_active == true:
		$Closed.visible = true
		$StaticBody2D/CollisionShape2D.disabled = false
		$Opened.visible = false
	else:
		$Closed.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		$Opened.visible = true
