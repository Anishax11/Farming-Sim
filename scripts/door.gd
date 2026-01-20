extends Area2D

var interior=preload("res://scenes/house_interior.tscn")
var time_manager
#func _ready() -> void:
	#time_manager=get_node("TimeManager")
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			#print("Door clicked")
			#if !TaskManager.tasks["Task3"]["acquired"] or !body.name == "Farmer":
				#print("Talk to aria/ not farmer")
				#return
			#if !TaskManager.tasks["Task3"]["completed"]:
				#print("Complete registrations")
				#return
				
			var time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
			if time_manager==null:
				print("TIme manager is null")
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
			
			get_tree().change_scene_to_packed(interior)
			
		 	
		 
			
			


func _on_body_entered(body: Node2D) -> void:
	if !TaskManager.tasks["Task3"]["acquired"] or !body.name == "Farmer":
				print("Talk to aria/ not farmer")
				return
	if !TaskManager.tasks["Task3"]["completed"]:
				print("Complete registrations")
				return
				
	var time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	if time_manager==null:
			print("TIme manager is null")
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
			
			get_tree().change_scene_to_packed(interior)
