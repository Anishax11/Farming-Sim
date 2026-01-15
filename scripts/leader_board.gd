extends Area2D
var entries = []
var top_5 
var disable_display = false
func _ready() -> void:
	if Global.day_count == 1:
		queue_free()
	for name in Tutorials.PointTracker:
		entries.append({
		"name": name,
		"points": Tutorials.PointTracker[name]})
		
	entries.sort_custom(func(a, b): #Sort by points (descending)
		return a.points > b.points)
		
	top_5 = entries.slice(0, min(5, entries.size()))
	TaskManager.task_status["top_5"] = top_5
	print("TOp 5 is set")
	if Global.day_count>=5:
		disable_display = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if disable_display:
				print("DIsplay disabled")
				return
			print("PRESSES")
			if Global.day_count==7:
				get_parent().get_node("LabelCanvas/LeaderBoardDisplay").visible = !get_node("LeaderBoardDisplay").visible
			get_node("LeaderBoardDisplay").visible = !get_node("LeaderBoardDisplay").visible
			print("LeaderBoardDisplay visible :",get_node("LeaderBoardDisplay").visible)
