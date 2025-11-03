extends CanvasLayer

func _ready() -> void:
	scale = Vector2(get_window().size.x / 1920.0, get_window().size.y / 1080.0)
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
	queue_free()
