extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Interact with noa")
			if Tutorials.interactions["noa"]==false:
				Dialogic.VAR.set("noa_intro",false)
				Tutorials.interactions["noa"]=true
			else:
				Dialogic.VAR.set("noa_intro",true)
			
			Dialogic.VAR.set("random",randi_range(1, 2))
			print("Random :",Dialogic.VAR.random)
			Dialogic.start("Noa")
