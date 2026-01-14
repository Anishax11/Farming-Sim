extends StaticBody2D
var LIBRARY_INTERIOR = load("res://scenes/library_interior.tscn")
var time_manager
func _ready() -> void:
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
func _on_door_body_entered(body: Node2D) -> void:
	if !TaskManager.tasks["Task3"]["acquired"]:
				print("Talk to aria")
				return
	if !TaskManager.tasks["Task3"]["completed"]:
				print("Complete registrations")
				return
				
	if body.name =="Farmer" :
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		await get_tree().change_scene_to_packed(LIBRARY_INTERIOR)
