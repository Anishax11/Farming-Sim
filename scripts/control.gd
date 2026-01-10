extends StaticBody2D


func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("INput")
		print(self.name+"DialDisplay")
		get_tree().current_scene.find_child(self.name+"DialDisplay",true,false).visible = !get_tree().current_scene.find_child(self.name+"DialDisplay",true,false).visible
