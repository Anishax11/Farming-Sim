extends Panel

	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:   
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Clicked panel")
		elif ! event.pressed:
			print("Left button")
