extends CharacterBody2D

var hp = 40

func _physics_process(_delta: float) -> void:
	if hp <= 0:
		die()


func die():
	queue_free()
