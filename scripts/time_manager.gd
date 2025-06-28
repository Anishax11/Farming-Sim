extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.0
var color_rect
func _ready() -> void:
	get_node("Label").text=("Time passed:"+str(current_time))
	color_rect=get_node("/root/Game/CanvasLayer/ColorRect") 
	
	
func _physics_process(delta: float) -> void:
	
	if current_time<24:
		time_passed+=delta
		if time_passed-initial_time > 3:
			initial_time=time_passed
			print("Initial Time :",initial_time)	
			print("Time passed:",time_passed)
			current_time+=2
			get_node("Label").text=("Time : "+str(int(current_time)))
			color_rect.adjust_tint()
	else:
		color_rect.i=0
		current_time=6.0
		time_passed=0.0
		initial_time=0.0
