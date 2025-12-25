extends Area2D



var Coin = 0


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Coin += 1
		queue_free()
