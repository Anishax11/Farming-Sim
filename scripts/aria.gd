extends Area2D
var rng := RandomNumberGenerator.new()
var aria_strawberry_task_given 

func _ready() -> void:
	print("Aria here")
	if Global.day_count>2 and TaskManager.tasks["Task2"]["acquired"]==true:
		for i in range (3):
			for j in range (5):
				var string=Global.inventory_items[i][j]
					
				if string=="strawberry":
					Dialogic.VAR.set("aria_task_done",true)
					print("Aria tsk done set true")
		

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			Dialogic.VAR.set("aria_strawberry_task_given",Tutorials.interactions["aria_strawberry_task_given"])
			if Tutorials.interactions["aria"]==false:
				print("Interact with aria")
				Dialogic.start("AriaSeedShopDirections")
				print("Interact with aria")
				Tutorials.interactions["aria"]=true
			else:
				#rng.randomize()
				Dialogic.signal_event.connect(_on_dialogic_signal)
				Dialogic.VAR.set("random",randi_range(1, 2))
				print("Randome :",Dialogic.VAR.random)
				Dialogic.start("Aria")

func _on_dialogic_signal(argument : String):
	if argument=="aria_strawberry_task_accepted":
		if !TaskManager.tasks["Task2"]["acquired"]:
			print("Aria task accepted")
			get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task2")
			Tutorials.interactions["aria_strawberry_task_given"]=true
	elif argument== "aria_strawberry_task_complete":
		print("Task Complete!")
		TaskManager.tasks["Task2"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task2")
		
		for i in range (3): #Delete strawberry from inv
			for j in range (5):
				var string=Global.inventory_items[i][j]
					
				if string=="strawberry":
					
					var number = i*5 +1+j
					get_tree().current_scene.find_child("Panel"+number,true,false).remove_item()
	
	elif argument== "Task1_acquired":
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task1")
