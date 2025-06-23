extends Area2D



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		if event.pressed:
			get_node("/root/Game/Farmer/Inventory").add_to_inventory(self.name)
