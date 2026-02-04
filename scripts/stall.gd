extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")
var camera
var player
var time_manager
var opening_time = 6
var closing_time = 21
const SEED_SHOP_INTERIOR = preload("res://scenes/seed_shop_interior.tscn")



func _ready():
	#print("STALL z index: ",z_index)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	camera=get_parent().get_node("Farmer/Camera2D")
	player=get_parent().get_node("Farmer")
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	
		

func _on_body_entered(body: Node2D) -> void:
	if body.name !="Farmer":
		return
	
	if !TaskManager.tasks["Task3"]["completed"]:
				print("Register")
				Dialogic.VAR.set("complete_registration",true)
				Dialogic.start("GeneralMessages")
				return
				
	if !(time_manager.current_time > opening_time and time_manager.current_time < closing_time):
		print("Seed shop closed")
		Dialogic.VAR.set("seed_shop_closed",true)
		Dialogic.start("GeneralMessages")
		return
	
	if (Global.day_count == 7 and time_manager.current_time>=6)	:
		print("Head to fest centre")
		Dialogic.VAR.set("go_to_fest",true)
		Dialogic.start("GeneralMessages")
		return			
		
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	await get_tree().change_scene_to_packed(SEED_SHOP_INTERIOR)

func _on_timeline_ended():
	Dialogic.VAR.set("complete_registration",false)
	Dialogic.VAR.set("seed_shop_closed",false)
	Dialogic.VAR.set("go_to_fest",false)
