extends Sprite2D
var clicked = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton :  
		if event.pressed:
			#get_node("Dial").rotation+=45
			print("Rotate dial")
