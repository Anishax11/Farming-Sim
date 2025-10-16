extends Button


func _gui_input(event):
	if event is InputEventMouseMotion:
		if get_rect().has_point(to_local(event.position)):
			# Mouse is over the button
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
