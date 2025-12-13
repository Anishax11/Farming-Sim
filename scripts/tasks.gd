extends Control

#CHANGE READY CODE, ONLY ADD TASKS THAT HAVE BEEN PREVIOUSLY ADDED THROUGH ADD TASK
var vb
var tasks

func _ready() -> void:
	tasks=TaskManager.tasks
	#if TaskManager.keys_array.size()==0:
		#print("keys  array empty")
	vb = get_tree().current_scene.find_child("TaskVBoxContainer", true, false)
	for i in range(TaskManager.keys_array.size()):
		var id = TaskManager.keys_array[i]         # "Task1"
		var task = tasks[id]
		#print("Task acq :",task["acquired"])
		print("Task complete:",task["completed"])
		if task["acquired"] and !task["completed"]:
			print("Acquired and not completed!")
			var label = Label.new()
			label.name=id
			label.add_theme_font_size_override("font_size", 50)
			label.text = task["title"] + ": " + task["Desc"]
			label.add_theme_color_override("font_color", Color.BLACK)
			label.custom_minimum_size = Vector2(600, 50)  # Godot 4 replacement for rect_min_size
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			label.z_index=4
			
			vb.add_child(label)
			
	#var timer = Timer.new()
	#timer.wait_time = 3.0  # 3 seconds
	#timer.one_shot = true
	#add_child(timer)
	#timer.start()
	#timer.timeout.connect(func():
	#
		#add_task("Task1")
		#timer.queue_free()  # free the timer after it triggers
	#)
	
func remove_task(task):
	print("Remove task called ")
	for child in vb.get_children():
		if child.name==task:
			child.queue_free()
			print("Removed task  ")


func add_task(task_name) :
	var task = tasks[task_name]
	var label = Label.new()
	label.name=task_name
	label.add_theme_font_size_override("font_size", 50)
	label.text=task.title+": "+task.Desc
	label.add_theme_color_override("font_color", Color.BLACK)
	label.custom_minimum_size = Vector2(600, 50)  # Godot 4 replacement for rect_min_size
	#label.wrap = true  # Godot 4 way to enable word wrapping
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	#label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	#label.custom_minimum_size = Vector2(200, 50)
	label.z_index=4
	
	vb.add_child(label)
	TaskManager.tasks[task_name]["acquired"]=true
	TaskManager.keys_array.append(task_name)
	print("added task")
