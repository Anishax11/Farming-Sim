extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.0
var time_to_change_tint=8.0
var minutes=0
var color_rect
func _ready() -> void:
	get_node("Label").text=("Time passed:"+str(current_time))
	color_rect=get_node("/root/Game/farm_scene/CanvasLayer/ColorRect") 
	if Global.load_farm==true:
		print("LOad farm")
		current_time=Global.current_time
		time_to_change_tint=Global.time_to_change_tint
		color_rect.i=Global.tint_index
		
		color_rect.adjust_tint()
		
		#
	
func _physics_process(delta: float) -> void:
	
	
		
	if current_time<24:
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
				print("Change tint")
				time_to_change_tint+=2
				color_rect.adjust_tint()
	else:
		time_to_change_tint=8.0
		color_rect.i=0
		current_time=6.0
		time_passed=0.0
		initial_time=0.0
