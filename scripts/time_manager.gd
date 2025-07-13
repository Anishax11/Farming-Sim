extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.0
var time_to_change_tint=8.0
var minutes=0
var color_rect
var date_label
var game
func _ready() -> void:
	
	game=get_node("/root/Game")
	date_label=get_node("/root/Game/farm_scene/Farmer/DateLabel")
	get_node("Label").text=("Time passed:"+str(current_time))
	color_rect=get_node("/root/Game/farm_scene/CanvasLayer/ColorRect") 
	if Global.load_farm==true:
		
		current_time=Global.current_time
		time_to_change_tint=Global.time_to_change_tint
		color_rect.i=Global.tint_index
		
		color_rect.adjust_tint()
		
		#
	
func _physics_process(delta: float) -> void:
	
	
		
	if current_time!=null and current_time<24:
		time_passed+=delta
		if time_passed-initial_time > 1:
			initial_time=time_passed
			#print("Initial Time :",initial_time)	
			#print("Time passed:",time_passed)
			current_time+=0.10
			minutes=round(fmod(current_time,1)*100)
			if minutes>=60:
				minutes=0
				current_time=int(current_time+1)
			#print("fmod:",minutes)
			get_node("Label").text=("Time : "+str(int(current_time))+":"+str(minutes))
			if current_time==time_to_change_tint:
			
				time_to_change_tint+=2
				color_rect.adjust_tint()
	elif current_time!=null:
		Global.day_count+=1
		Global.day_passed=true
		date_label.update_day_count()
		Global.time_to_change_tint=8.0
		Global.tint_index=0
		Global.current_time=6.0
		time_passed=0.0
		initial_time=0.0
		
		await get_tree().reload_current_scene()
		Global.load_farm=true
