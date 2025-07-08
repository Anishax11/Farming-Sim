extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.0
var time_to_change_tint=8.0
var minutes=0
var color_rect_i
func _ready() -> void:
	get_node("Label").text=("Time passed:"+str(current_time))
	print("HOUSE")
	current_time=Global.current_time
	print("color_rect_i:",color_rect_i)
	time_to_change_tint=Global.time_to_change_tint
	color_rect_i=Global.tint_index
	
func _physics_process(delta: float) -> void:
	
	
		
	if current_time<24:
		time_passed+=delta
		if time_passed-initial_time > 0.5:
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
				color_rect_i+=1
				print("Change tint")
				time_to_change_tint+=2
				
	else:
		time_to_change_tint=8.0
		color_rect_i=0
		current_time=6.0
		time_passed=0.0
		initial_time=0.0
