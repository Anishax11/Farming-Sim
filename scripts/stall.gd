extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")
var camera
var player
var time_manager
const SEED_SHOP_INTERIOR = preload("res://scenes/seed_shop_interior.tscn")



func _ready():
	print("STALL z index: ",z_index)
	camera=get_parent().get_node("Farmer/Camera2D")
	player=get_parent().get_node("Farmer")
	time_manager=get_parent().get_node("Farmer/TimeManager")
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		#get_parent().get_node("TileMap").visible=false
		#get_parent().get_node("Node2D").visible=false
		#get_parent().get_node("FrontYardEntrance").visible=false
		#get_node("CollisionShape2D").visible=false
		#get_node("TileMap").visible=false
		#
		#
		#print("POS:",camera.global_position)
		#get_node("SeedShopInterior").visible=true
		#camera.top_level = true
		#camera.global_position=Vector2(-120,0)
		#player.global_position=Vector2(-120,118)
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		await get_tree().change_scene_to_packed(SEED_SHOP_INTERIOR)
		
		#var seeds=SEEDS.instantiate()
		#seeds.scale=Vector2(5,5)
		#add_child(seeds)
#func _process(delta: float) -> void:
	#print(get_parent().get_node("Farmer").global_position)
