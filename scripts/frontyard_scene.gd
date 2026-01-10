extends Node2D
var time_manager
const MARKET_PLACE = preload("res://scenes/market_place.tscn")
var slots_passed=0
var slot_adjust=1
@onready var bg_music: AudioStreamPlayer2D = $BGMusic

func _ready() -> void:
	Global.music_fade_in()
	Dialogic.end_timeline()
	var labelcanvas = $LabelCanvas   # adjust path if needed
	var root = get_tree().current_scene
	var inventory = get_node("Farmer/ClickBlocker/Inventory")
	#inventory.add_to_inventory("strawberry_seeds",Global.strawberry_image)
	#inventory.add_to_inventory("potato_seeds",Global.potato_image)
	#inventory.add_to_inventory("pumpkin_seeds",Global.pumpkin_image)
	#inventory.add_to_inventory("watercan",Global.pumpkin_image)
	#inventory.add_to_inventory("pumpkin",Global.pumpkin_image)
	#inventory.add_to_inventory("potato",Global.potato_image)
	#inventory.add_to_inventory("strawberry",Global.strawberry_image)
	#inventory.add_to_inventory("strawberry",Global.strawberry_image)
	#inventory.add_to_inventory("watercan",Global.strawberry_image)
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	var player =get_node("Farmer")
	if Global.player_pos!=null:
		player.global_position=Global.player_pos
	
	if(Global.player_direction.y==-1):
		player.animated_sprite_2d.play("backward")
	else:
		player.animated_sprite_2d.play("forward")
	

	



func _on_market_entrance_body_entered(body: Node2D) -> void:
	if body.name!="Farmer" :
		return
	if Global.player_direction.y==1:
		print("REAChed MArket Entrance")
		Global.player_pos = Vector2(-214, -187)
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)
		
		
		
func print_all_children(node: Node, indent := 0):
	for child in node.get_children():
		print("  ".repeat(indent) + child.name)
		print_all_children(child, indent + 1)
