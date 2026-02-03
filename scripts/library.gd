extends StaticBody2D
var LIBRARY_INTERIOR = load("res://scenes/library_interior.tscn")
var time_manager
var opening_time = 8
var closing_time = 21
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
				
	if !(time_manager.current_time > opening_time and time_manager.current_time < closing_time):
		print("Library closed")
		Dialogic.VAR.set("library_closed",true)
		Dialogic.start("GeneralMessages")
		return
	
	if (Global.day_count == 7 and time_manager.current_time>=10)	:
		print("Head to fest centre")
		Dialogic.VAR.set("go_to_fest",true)
		Dialogic.start("GeneralMessages")
		return		
	
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	await get_tree().change_scene_to_packed(LIBRARY_INTERIOR)


func _on_dialogic_ended():
	Dialogic.VAR.set("aria_talk",false)
	Dialogic.VAR.set("library_closed",false)
	Dialogic.VAR.set("go_to_fest",false)
