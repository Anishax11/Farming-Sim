extends Area2D

var interior=preload("res://scenes/house_interior.tscn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			print("Door clicked")
			get_tree().change_scene_to_packed(interior)
			
		 	
		 
			
			
