extends Node2D

@export var item_price: int = 0

func _ready() -> void:
	$Label.text = "+" + str(item_price) + "$"
	$Label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Globals.money += item_price
		$Sprite2D.visible = false
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("pick_up")
		await $AnimationPlayer.animation_finished
		queue_free()

func _on_despawn_timer_timeout() -> void:
	queue_free()
