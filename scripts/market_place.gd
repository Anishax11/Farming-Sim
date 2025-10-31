extends Node2D
var game = load("res://scenes/game.tscn")
var player 
var time_manager

func _ready():
	print("MARKET Place")
	player=get_node("Farmer")
	time_manager=get_node("Farmer/TimeManager")
	if Global.player_pos!=null:
		player.global_position = Global.player_pos

	#
#func _process(delta: float) -> void:
	#print("ZOOM:",player.get_node("Camera2D").zoom)

func _on_front_yard_entrance_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==-1:
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(game)
		#print("PLayer dir:",Global.player_direction.y)	
		print("PLayer here")
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		
