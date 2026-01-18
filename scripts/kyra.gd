extends CharacterBody2D


#func _ready() -> void:
	#if Global.day_count<5:
		#queue_free()



func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	Dialogic.VAR.set("talk_to_bullies_given",TaskManager.tasks["Task10"]["acquired"])
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("Kyra")

func _on_dialogic_signal(arg : String):
	if arg =="talked_to_bully":
		TaskManager.tasks["Task10"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task10")
