extends Node2D
var player 
var time_manager
var date_label
var coin_label
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")

func _ready():
	Global.music_fade_in()
	Dialogic.end_timeline()
	print("MARKET Place")
	player=get_node("Farmer")
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	date_label = get_tree().get_current_scene().find_child("DateLabel",true,false)
	coin_label=get_tree().get_current_scene().find_child("CoinLabel",true,false)
	player.get_node("Camera2D").zoom=Vector2(2,2)
	if Global.player_pos!=null:
		player.global_position = Global.player_pos
	print("PLayer Pos :",player.global_position)

	#
#func _process(delta: float) -> void:
	#print("ZOOM:",player.get_node("Camera2D").zoom)

func _on_front_yard_entrance_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==-1:
		print("PLayer here")
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		Global.player_pos = Vector2(300,850)
		Global.player_direction.y = -1
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)
		
		
		#print("PLayer dir:",Global.player_direction.y)	
		
