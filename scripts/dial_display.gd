extends Control

func _on_gui_input(event: InputEvent) -> void:
	print("COntrol input")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Pressed")
			get_node("TextureRect").rotation+=45
