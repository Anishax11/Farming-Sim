extends Area2D

var interior=preload("res://scenes/house_interior.tscn")
var time_manager
#func _ready() -> void:
	#time_manager=get_node("TimeManager")
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			#print("Door clicked")
			var time_manager=get_parent().get_node("Farmer/TimeManager")
			if time_manager==null:
				print("TIme manager is null")
			#Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i)
			Global.current_time=time_manager.current_time
			Global.time_to_change_tint=time_manager.time_to_change_tint
			Global.tint_index=time_manager.color_rect.i
			get_tree().change_scene_to_packed(interior)
			
		 	
		 
			
			
