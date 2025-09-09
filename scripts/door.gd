extends Area2D

var interior=preload("res://scenes/house_interior.tscn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			#print("Door clicked")
			var time_manager=get_node("/root/Game/frontyard_scene/Farmer/TimeManager")
			if time_manager==null:
				print("TIme manager is null")
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i)
			get_tree().change_scene_to_packed(interior)
			
		 	
		 
			
			
