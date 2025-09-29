extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.gd")
var time_manager
var game = load("res://scenes/game.tscn")
#
#func _ready() -> void:
	#var inventory=get_node("Farmer/Inventory")
	#for i in range (3):
		#for j in range (5):
			#var string=Global.inventory_items[i][j]
				#
			#if string!="":
				#Global.inventory_items[i][j]=""
				#inventory.add_to_inventory(string,null)
				
func _on_exit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			print("LEAVE  FARM")
			time_manager=get_node("/root/farm_scene/Farmer/TimeManager")
			Global.current_time=time_manager.current_time
			Global.time_to_change_tint=time_manager.time_to_change_tint
			Global.tint_index=time_manager.color_rect.i
			await get_tree().change_scene_to_packed(game)
			Global.load_frontyard=true
