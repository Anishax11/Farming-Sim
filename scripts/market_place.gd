extends Node2D
var player 
var time_manager
var date_label
var coin_label
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
var camera

func _ready():
	Dialogic.end_timeline()
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Global.music_fade_in()

	player=get_node("Farmer")
	camera = player.get_node("Camera2D")
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	date_label = get_tree().get_current_scene().find_child("DateLabel",true,false)
	coin_label=get_tree().get_current_scene().find_child("CoinLabel",true,false)
	player.get_node("Camera2D").zoom=Vector2(2,2)
	if Global.player_pos!=null:
		player.global_position = Global.player_pos
	print("PLayer Pos :",player.global_position)
	camera.limit_bottom = 425
	camera.limit_top = -320
	camera.limit_left = -1150
	camera.limit_right = 380

	#
#func _process(delta: float) -> void:
	#print("ZOOM:",player.get_node("Camera2D").zoom)

func _on_front_yard_entrance_body_entered(body: Node2D) -> void:
	
		if !TaskManager.tasks["Task3"]["completed"]:
				print("Register")
				Dialogic.VAR.set("complete_registration",true)
				Dialogic.start("GeneralMessages")
				
				return
		if !TaskManager.tasks["Task8"]["completed"]: #complete registration and buy seeds first
				print("Buy Seeds")
				
				Dialogic.VAR.set("seeds_bought",true)
				Dialogic.start("GeneralMessages")
				
				return
				
		
				
		if Global.player_direction.y==-1:
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
			Global.player_pos = Vector2(300,850)
			Global.player_direction.y = -1
			Global.music_fade_out()
			get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)
		#print("PLayer dir:",Global.player_direction.y)	
		

func _on_timeline_ended():
	Dialogic.VAR.set("seeds_bought",false)
	Dialogic.VAR.set("complete_registration",false)
