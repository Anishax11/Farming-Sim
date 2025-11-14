extends Control

func _ready() -> void:
	var tasks=TaskManager.tasks
	var keys_array = tasks.keys()
	for i in range(keys_array.size()):
		var id = keys_array[i]         # "Task1"
		var task = tasks[id]
		
 
		 
		if task.acquired and !task.completed:
			print("Acquired and not completed!")
			var label = Label.new()
			label.add_theme_font_size_override("font_size", 50)
			label.text=task.title+": "+task.Desc
			label.custom_minimum_size = Vector2(200, 50)  # Godot 4 replacement for rect_min_size
			#label.wrap = true  # Godot 4 way to enable word wrapping
			label.z_index=4
			var vb = get_tree().current_scene.find_child("TaskVBoxContainer", true, false)
			vb.add_child(label)
			
