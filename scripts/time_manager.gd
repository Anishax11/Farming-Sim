extends Node2D

var time_passed=0.0
var initial_time=0.0
var current_time=6.0
var time_to_change_tint=6.0
var minutes=0
var color_rect
var date_label
var game
var HOUSE_INTERIOR = load("res://scenes/house_interior.tscn")
func _ready() -> void:
	
	
	#print("Path:",get_path())
	#game=get_node("/root/Game")
	date_label=get_parent().get_node("DateLabel")
	get_node("Label").text=("Time passed:"+str(current_time))
	color_rect=get_parent().get_node("CanvasLayer/ColorRect") 
	if current_time == time_to_change_tint:
			color_rect.adjust_tint()
	if Global.current_time!=null:
		current_time=Global.current_time
		time_to_change_tint=Global.time_to_change_tint
		color_rect.i=Global.tint_index
		
		print("Time managed")
	if color_rect==null:
		print("COLOR RECT IS NULL")
	#if Global.load_farm==true or Global.load_frontyard==true:
		#
		#current_time=Global.current_time
		#time_to_change_tint=Global.time_to_change_tint
		#color_rect.i=Global.tint_index
		#
		#color_rect.adjust_tint()
	#else:
		#print("Load farm is false")
		
	
func _physics_process(delta: float) -> void:

	if current_time!=null and current_time<24:
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
				print("Time to chnge tint :",time_to_change_tint)
				time_to_change_tint+=2
				color_rect.adjust_tint()
	elif current_time!=null:
		
		
		Global.update_day_count()
		#Global.load_farm=true


	
