extends Node2D
var time_manager
const MARKET_PLACE = preload("res://scenes/market_place.tscn")
var slots_passed=0
var slot_adjust=1

func _ready() -> void:
	time_manager=get_node("Farmer/TimeManager")
	var player =get_node("Farmer")
	if Global.player_pos!=null:
		player.global_position=Global.player_pos
	#time_manager.current_time=Global.current_time
	#time_manager.time_to_change_tint=time_manager.time_to_change_tint
	#time_manager.tint_index=time_manager.color_rect.i
#func _on_farm_entrance_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#
	#if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		#if event.pressed:
			#print("Open farm")
			#time_manager=get_node("/root/Game/frontyard_scene/Farmer/TimeManager")
			#Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i)
			#await get_tree().change_scene_to_packed(FARM_SCENE)
			#Global.load_farm=true





func _on_market_entrance_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==1:
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)
		print("REAChed MArket Entrance")
		
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		
		
