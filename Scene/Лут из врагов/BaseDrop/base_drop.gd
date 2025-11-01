extends Node2D

@export var item_price: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Globals.money += item_price
		queue_free()
