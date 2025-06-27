extends Area2D



	


func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		print("FARMER Y pos",body.position.y)
		print("PLANT:",position.y)
		z_index=-1


func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		
		z_index=0
