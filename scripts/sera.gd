extends Area2D

#func _ready():
	#if Global.day_count == 1:
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.VAR.set("registration_done",Tutorials.interactions["registration_done"])
	Dialogic.VAR.set("current_scene",get_tree().current_scene)
	Dialogic.VAR.set("sera_intro",Tutorials.interactions["sera"])	
	Dialogic.start("Sera")
	
func _on_dialogic_signal(argument : String):
	if argument == "registration_done":
		Tutorials.interactions["registration_done"] = true
	elif argument == "sera_intro":
		Tutorials.interactions["sera"]=true
