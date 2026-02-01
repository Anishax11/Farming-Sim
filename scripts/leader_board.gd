extends StaticBody2D
var entries = []
var top_5 
var disable_display = false
var max_point_diff = 400
var point_increment_limit = 100
var player
var leaderboard_display
var OPENING_SCENE = load("res://scenes/opening_scene.tscn")
func _ready() -> void:
	
	if Global.day_count == 1:
		queue_free()
	leaderboard_display = get_tree().current_scene.find_child("LeaderBoardDisplay",true,false)
	player = get_tree().current_scene.find_child("Farmer",true,false)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	for name in Tutorials.PointTracker:
		entries.append({
		"name": name,
		"points": Tutorials.PointTracker[name]})
		
	entries.sort_custom(func(a, b): #Sort by points (descending)
		return a.points > b.points)
		
	top_5 = entries.slice(0, min(5, entries.size()))
	TaskManager.task_status["top_5"] = top_5
	#print("TOp 5 is set")
	if Global.day_count>=5:
		disable_display = true

	
			#print("LeaderBoardDisplay visible :",get_node("LeaderBoardDisplay").visible)

func allot_points():
	for npc in entries:
		if !npc["name"]=="You":
			var increment = randi_range(0,point_increment_limit)
			if ((npc["points"] +increment- player.points)>max_point_diff):
				npc["points"]=max_point_diff+ player.points
			else:
				npc["points"]+=increment
			
			Tutorials.PointTracker[npc["name"]] = npc["points"]


func _on_input_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if disable_display:
				Dialogic.VAR.set("leaderboard_broken",true)
				Dialogic.start("GeneralMessages")
				print("DIsplay disabled")
				return
			print("PRESSES")
			leaderboard_display.visible = !leaderboard_display.visible
			if Global.day_count==7:
				print("STArt timer")
				var timer = Timer.new()
				timer.timeout.connect(_on_timer_timeout)
				timer.wait_time = 5.0
				add_child(timer)
				timer.start()
				#
				#leaderboard_display.visible = !leaderboard_display
			#else:
				#leaderboard_display = !leaderboard_display
func _on_timer_timeout():
	print("Time up")
	get_tree().change_scene_to_packed(OPENING_SCENE)

func _on_timeline_ended():
	Dialogic.VAR.set("leaderboard_broken",false)
