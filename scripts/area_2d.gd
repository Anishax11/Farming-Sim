extends Area2D



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouse and event.button_index==MOUSE_BUTTON_LEFT:
		get_parent().get_node("Label").text="GO TO SLEEP?" 
