extends CharacterBody2D
var farmer
var inventory
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	farmer =  get_tree().current_scene.find_child("Farmer",true,false)
	if TaskManager.tasks["Task6"]["completed"]:
		queue_free()
	Dialogic.VAR.set("talk_to_maya_task_given",TaskManager.tasks["Task9"]["acquired"])
	Dialogic.VAR.set("talk_to_maya_task_done",TaskManager.tasks["Task9"]["completed"])
	inventory = get_tree().current_scene.find_child("Inventory",true,false)
	
func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			farmer.input_disabled = true
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
	if argument =="measured_faith_given" and !TaskManager.tasks["Task6"]["acquired"]:
		TaskManager.tasks["Task6"]["acquired"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task6")
	if argument =="talk_to_maya_given" and !TaskManager.tasks["Task9"]["acquired"]:
		TaskManager.tasks["Task9"]["acquired"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task9")
	if argument == "measured_faith_complete":
		inventory.add_to_inventory("special_seeds",Global.strawberry_image)
		var empty_panel = Global.get_empty_panel()
		empty_panel.seed_count = 6
		PlantTracker.panel_info[empty_panel.name]["seed_count"] = 6
		
func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_timeline_ended():
	farmer.input_disabled = false
