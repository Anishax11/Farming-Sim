extends Area2D
var CHURCH_INTERIOR = load("res://scenes/church_interior.tscn")
var time_manager
var Dim_bg
func _ready() -> void:
	
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	Dim_bg = get_tree().current_scene.find_child("DimBG",true,false)
	
func _on_body_entered(body: Node2D) -> void:
	
	if Global.player_direction.y==-1:
		if body.name!="Farmer":
				return
	#Dialogic.timeline_ended.connect(_on_dialogic_ended)
	#if !TaskManager.tasks["Task3"]["acquired"] or !body.name == "Farmer":
		#print("Talk to aria/ not farmer")
		#if !TaskManager.tasks["Task3"]["acquired"]:
				#print("Talk to aria")
				#Dialogic.VAR.set("aria_talk",true)
				#Dialogic.start("GeneralMessages")
				#print("Aria talk :",Dialogic.VAR.aria_talk)
				##Dialogic.VAR.set("aria_talk",false)
				#
				#return
	#if !TaskManager.tasks["Task3"]["completed"]:
				#print("Complete registrations")
				#Dialogic.VAR.set("complete_registration",true)
				#Dialogic.start("GeneralMessages")
				#return
		
		Global.player_pos = Vector2(475, 600)
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		Global.music_fade_out()
		Dim_bg.dim_bg(CHURCH_INTERIOR)

func _on_dialogic_ended():
	Dialogic.VAR.set("aria_talk",false)
	Dialogic.VAR.set("complete_registration",false)
