extends Area2D
var rng := RandomNumberGenerator.new()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if Tutorials.interactions["aria"]==false:
				Dialogic.start("AriaSeedShopInfo")
				Tutorials.interactions["aria"]=true
			else:
				rng.randomize()
				print("Interact with aria")
				Dialogic.VAR.set("random",RandomNumberGenerator.new().randi_range(1, 2))
				print("Randome :",Dialogic.VAR.random)
				Dialogic.start("Aria")
