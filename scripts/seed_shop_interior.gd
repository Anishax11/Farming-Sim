extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")
var MARKET_PLACE = load("res://scenes/market_place.tscn")

var time_manager

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("DIsplay menu 1")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			
			get_node("VendorMenu").visible=!get_node("VendorMenu").visible


func _ready() -> void:
	print(get_path())
	get_node("Farmer/TimeManager").queue_free()
	get_node("Farmer/DateLabel").queue_free()
	time_manager=get_node("TimeManager")
	Dialogic.start("SeedShopOwner")
	#get_node("Farmer/Camera2D").queue_free()
##
	##get_node("VendorMenu").mouse_filter = Control.MOUSE_FILTER_IGNORE

func exit_shop():
	
	print("EXITTT")
	Global.current_time = time_manager.current_time
	Global.time_to_change_tint = time_manager.time_to_change_tint
	Global.tint_index = time_manager.color_rect.i
	await get_tree().change_scene_to_packed(MARKET_PLACE)

	
	#get_parent().get_parent().visible=false
	
