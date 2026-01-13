extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.00
var time_to_change_tint=6.00
var minutes=00
var display_minutes
var color_rect
var date_label
var game
var HOUSE_INTERIOR = load("res://scenes/house_interior.tscn")
var npc_manager
func _ready() -> void:
	print("Time Manager Loaded")
	color_rect=get_tree().get_current_scene().find_child("ColorRect",true,false)
	npc_manager = get_tree().current_scene.find_child("NPCManager",true,false)
	date_label=get_parent().get_node("DateLabel")
	if Global.current_time!=null:
		current_time=Global.current_time
		minutes = Global.minutes
		print("Adjust time")
		time_to_change_tint=Global.time_to_change_tint
		color_rect.i=Global.tint_index
	get_node("Label").text=("Time : "+str(int(current_time))+":"+str(minutes))	
	
	if current_time == time_to_change_tint:
			color_rect.adjust_tint()
	

		
	
func _physics_process(delta: float) -> void:
	if Global.freeze_time:
		return

	if current_time!=null and current_time<24:
		time_passed+=delta
		if time_passed-initial_time > 2:
			initial_time=time_passed
			#print("Initial Time :",initial_time)	
			#print("Time passed:",time_passed)
			current_time+=0.10
			minutes=round(fmod(current_time,1)*100)
			if minutes>=60:
				minutes=00
				#print("Calling hour elapsed")
				
				current_time=int(current_time+1)
				if npc_manager!=null:
					npc_manager.hour_elapsed()
			#print("fmod:",minutes)
			if !minutes == 00:
				display_minutes = str(minutes)
			else:
				display_minutes = "00"
			get_node("Label").text=("Time : "+str(int(current_time))+":"+display_minutes)
			if current_time==time_to_change_tint:
				#print("Time to chnge tint :",time_to_change_tint)
				time_to_change_tint+=2
				color_rect.adjust_tint()
	elif current_time!=null:
		
		
		Global.update_day_count()
		#Global.load_farm=true
	
	if current_time!=null and current_time==22 and Global.day_count==1:
		Dialogic.start("NightWarning")

	
