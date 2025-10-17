extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")
var MARKET_PLACE = load("res://scenes/market_place.tscn")

var time_manager

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("DIsplay menu 1")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			Dialogic.signal_event.connect(_on_dialogic_signal)
			Dialogic.start("SeedShopOwner")


func _ready() -> void:
	
	get_node("Farmer/TimeManager").queue_free()
	get_node("Farmer/DateLabel").queue_free()
	get_node("Farmer/Camera2D").queue_free()
	get_node("Farmer/Inventory").position.y=-80
	get_node("Farmer/Inventory").scale=Vector2(0.3,0.5)
	get_node("Farmer/AnimatedSprite2D").play("backward")
	Global.player_direction=Vector2(0,0)
	time_manager=get_node("TimeManager")
	
	#for child in get_children():
		#print(child.name)

	#get_node("Farmer/Camera2D").queue_free()
##
	##get_node("VendorMenu").mouse_filter = Control.MOUSE_FILTER_IGNORE

	#get_parent().get_parent().visible=false
	
func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==1:
		print("LEAVING SHOP")
		Dialogic.end_timeline()
		Global.current_time = time_manager.current_time
		Global.time_to_change_tint = time_manager.time_to_change_tint
		Global.tint_index = time_manager.color_rect_i
		get_node("CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)



	
	

func _on_dialogic_signal(argument : String):
	if argument=="OpenMenu":
		get_node("VendorMenu").visible=true


func _on_close_menu_button_down() -> void:
	print("Closing menu ")
	get_node("VendorMenu").visible=false
