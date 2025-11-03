extends CanvasLayer

func _ready() -> void:
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
	queue_free()
