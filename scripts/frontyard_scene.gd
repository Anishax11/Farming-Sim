extends Node2D
var time_manager
const MARKET_PLACE = preload("res://scenes/market_place.tscn")
var slots_passed=0
var slot_adjust=1
@onready var bg_music: AudioStreamPlayer2D = $BGMusic

func _ready() -> void:
	Global.music_fade_in()
	Dialogic.end_timeline()
	
	var inventory = get_node("Farmer/ClickBlocker/Inventory")
	inventory.add_to_inventory("pumpkin",Global.pumpkin_image)
	inventory.add_to_inventory("potato",Global.potato_image)
	inventory.add_to_inventory("strawberry",Global.strawberry_image)
	
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	var player =get_node("Farmer")
	if Global.player_pos!=null:
		player.global_position=Global.player_pos
	
	if(Global.player_direction.y==-1):
		player.animated_sprite_2d.play("backward")
	else:
		player.animated_sprite_2d.play("forward")
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
		print("REAChed MArket Entrance")
		Global.player_pos = Vector2(-214, -187)
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)
		
		
		
