extends Node2D
var time_manager
const MARKET_PLACE = preload("res://scenes/market_place.tscn")

func _ready() -> void:
	print("Frontyard:",self.get_path())
	var inventory=get_node("Farmer/Inventory")
	for i in range (3):
		for j in range (5):
			var string=Global.inventory_items[i][j]
				
			if string!="":
				Global.inventory_items[i][j]=""
				inventory.add_to_inventory(string,null)
				
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
		await get_tree().change_scene_to_packed(MARKET_PLACE)
