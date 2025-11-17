extends Node2D
var game = load("res://scenes/game.tscn")
var player 
var time_manager
var date_label
var coin_label
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
const GAME = preload("res://scenes/game.tscn")

func _ready():
	Global.music_fade_in()
	Dialogic.end_timeline()
	print("MARKET Place")
	player=get_node("Farmer")
	time_manager=get_node("Farmer/TimeManager")
	date_label = get_node("Farmer/DateLabel")
	coin_label=get_node("Farmer/CoinLabel")
	time_manager.global_position.y+=70
	date_label.global_position.y+=70
	date_label.global_position.x-=80
	time_manager.global_position.x-=110
	coin_label.global_position.y+=70
	coin_label.global_position.x+=110
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
		
