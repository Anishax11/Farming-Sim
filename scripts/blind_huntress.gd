extends CharacterBody2D

var inventory
func _ready() -> void:
	Dialogic.VAR.set("talk_to_maya_task_done",TaskManager.tasks["Task9"]["completed"])
	inventory = get_tree().current_scene.find_child("Inventory",true,false)
	
func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			Dialogic.signal_event.connect(_on_dialogic_signal)
			if TaskManager.tasks["Task6"]["acquired"]:
				Dialogic.VAR.set("measured_faith_given",true)
			if TaskManager.tasks["Task6"]["completed"]:
				Dialogic.VAR.set("measured_faith_complete",true)	
				
			Dialogic.VAR.set("ilyra_intro",Tutorials.interactions["ilyra"])
			
				
			if Tutorials.interactions["ilyra"]==false:
				Tutorials.interactions["ilyra"]=true
			
			#rng.randomize()
			#Dialogic.VAR.set("random",randi_range(1, 2))
			#print("Randome :",Dialogic.VAR.random)
			Dialogic.start("Lyra")


func _on_dialogic_signal(argument : String):
	if argument =="measured_faith_given":
		TaskManager.tasks["Task6"]["acquired"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task6")
	if argument =="talk_to_maya_given":
		TaskManager.tasks["Task9"]["acquired"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task9")
	if argument == "measured_faith_complete":
		inventory.add_to_inventory("special_seeds",Global.strawberry_image)
		Global.get_empty_panel().seed_count=6
