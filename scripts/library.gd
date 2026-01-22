extends StaticBody2D
var LIBRARY_INTERIOR = load("res://scenes/library_interior.tscn")
var time_manager
func _ready() -> void:
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	
func _on_door_body_entered(body: Node2D) -> void:
	if !body.name=="Farmer":
		return
	Dialogic.timeline_ended.connect(_on_dialogic_ended)
	if !TaskManager.tasks["Task3"]["acquired"]:
				print("Talk to aria")
				Dialogic.VAR.set("aria_talk",true)
				Dialogic.start("GeneralMessages")
				
				return
				
	
				
	
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	await get_tree().change_scene_to_packed(LIBRARY_INTERIOR)


func _on_dialogic_ended():
	Dialogic.VAR.set("aria_talk",false)
