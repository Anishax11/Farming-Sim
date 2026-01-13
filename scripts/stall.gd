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
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	
		

func _on_body_entered(body: Node2D) -> void:
	if body.name !="Farmer":
		return
	if !TaskManager.tasks["Task3"]["completed"]:
		
		return
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	await get_tree().change_scene_to_packed(SEED_SHOP_INTERIOR)
