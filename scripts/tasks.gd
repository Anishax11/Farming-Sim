extends Control

var vb
var tasks
var tasks_acquired = 0
func _ready() -> void:
	tasks=TaskManager.tasks
	#if TaskManager.keys_array.size()==0:
		#print("keys  array empty")
	vb = get_tree().current_scene.find_child("TaskVBoxContainer", true, false)
	if vb == null:
		print("VB IS NULL")
	else:
		print("VB IS NOT NULL")	
	for i in range(TaskManager.keys_array.size()):
		var id = TaskManager.keys_array[i]         # "Task1"
		var task = tasks[id]
		#print("Task acq :",task["acquired"])
		print("Task complete:",task["completed"])
		if task["acquired"] and !task["completed"]:
			print("Acquired and not completed!")
			var label = RichTextLabel.new()
			label.name=id
			label.add_theme_font_size_override("normal_font_size", 24)
			label.text =  str(i)+". "+task.title + ": " + task.Desc + "\n" 
			label.add_theme_color_override("default_color", Color.BLACK)
			label.size = Vector2(600, 180)
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			label.scroll_active = true
			label.scroll_following = false   # Player-controlled scroll
			label.clip_contents = true
			label.z_index=4
			
			vb.add_child(label)
			print("TAsk added")
			
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
	tasks_acquired-=1
	print("Remove task called ")
	for child in vb.get_children():
		if child.name==task:
			child.queue_free()
			print("Removed task  ")


func add_task(task_name) :
	tasks_acquired+=1
	var task = tasks[task_name]
	var label = RichTextLabel.new()
	label.name=task_name
	label.add_theme_font_size_override("normal_font_size", 40)
	label.text =  str(tasks_acquired)+". "+task.title + ": " + task.Desc + "\n" 
	label.add_theme_color_override("default_color", Color.BLACK)
	label.custom_minimum_size = Vector2(600, 150)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.scroll_active = true
	label.scroll_following = false   # Player-controlled scroll
	label.clip_contents = true
	label.z_index=4
	
	vb.add_child(label)
	TaskManager.tasks[task_name]["acquired"]=true
	TaskManager.keys_array.append(task_name)
	print("added task")
