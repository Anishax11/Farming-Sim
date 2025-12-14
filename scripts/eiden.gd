extends Area2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Interact with eiden")
			if Tutorials.interactions["eiden"]==false:
				Dialogic.VAR.set("eiden_intro",false)
			else:
				Dialogic.VAR.set("eiden_intro",true)
			
			Dialogic.VAR.set("random",randi_range(1, 2))
			print("Random :",Dialogic.VAR.random)
			Dialogic.start("Eiden")
