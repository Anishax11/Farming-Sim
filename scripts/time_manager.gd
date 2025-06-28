extends Node2D

var time_passed=0.0
var initial_time=0.0

func _physics_process(delta: float) -> void:
	
	time_passed+=delta
	if time_passed-initial_time > 1:
		initial_time=time_passed
		#print("Initial Time :",initial_time)	
		#print("Time passed:",time_passed)
		get_node("Label").text=("Time passed:"+str(int(time_passed)))
