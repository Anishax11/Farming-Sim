extends Panel

	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse and  event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked")
