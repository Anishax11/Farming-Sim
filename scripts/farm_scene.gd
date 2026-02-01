extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.tscn")
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
var time_manager
var game = load("res://scenes/game.tscn")
var farm_temp 
const ARIA = preload("res://scenes/aria.tscn")
var SERA = load("res://scenes/sera.tscn")
var aria
var sera
@onready var farmer: Player = $Farmer

func _ready() -> void:
	Dialogic.timeline_ended.connect(_timeline_ended)
	print("FARMMMMMM")
	#if PlantTracker.curr_farm_temp!=null:
		#farm_temp = PlantTracker.curr_farm_temp
		#print("FArm temp ;",farm_temp)
		#
	#else :
		#farm_temp = randi_range(18,40)
	if Global.day_count >= 2 and !TaskManager.tasks["Task5"]["acquired"]:
		print("SPawn sera")
		
		sera = SERA.instantiate()
		sera.z_index = 2
		sera.position = Vector2(250,250)
		sera.delay_schedule = true
		sera.get_node("NavigationAgent2D").target_position = Vector2(55,650)
		sera.free_later = true
		add_child(sera)
		#Dialogic.VAR.set("registration_done",true)
		#await Dialogic.start("Sera")
		
		
		
	print("Farm temp is : ",farm_temp)	
	#get_tree().current_scene.find_child("TempLabel",true,false).text="Temp : "+str(farm_temp)
	Global.music_fade_in()
	var player = get_node("Farmer")
	var cam=player.get_node("Camera2D")
	#cam.zoom.x+=0.6
	cam.limit_left=0
	cam.limit_right=775
	cam.limit_top=0
	cam.limit_bottom=500
	var inventory = get_tree().current_scene.find_child("Inventory",true,false)
	#inventory.add_to_inventory("potato",Global.pumpkin_image)
	#inventory.add_to_inventory("potato_seeds",Global.potato_image)
	#inventory.add_to_inventory("special_seeds",Global.strawberry_image)
	#Global.get_empty_panel().seed_count=6
	#inventory.add_to_inventory("strawberry_seeds",Global.strawberry_image)
	#Global.get_empty_panel().seed_count=6
	#inventory.add_to_inventory("strawberry_seeds",Global.strawberry_image)
	#Global.get_empty_panel().seed_count=6
	
	#if Global.player_pos!=null:
		#player.global_position=Global.player_pos
				#
	player.animated_sprite_2d.play("backward")

	
	if Tutorials.tutorials["farm_tutorial"]==false:
		Tutorials.tutorials["farm_tutorial"]=true	
		print("STart farm tut")
		Dialogic.start("FarmTutorial")	
		await Dialogic.timeline_ended
		
		
	if 	Tutorials.tutorials["temp_regulator_tutorial"]==false and TaskManager.tasks["Task2"]["completed"]==true:
		aria = ARIA.instantiate()
		aria.position = Vector2(250,250)
		aria.delay_schedule = true
		aria.get_node("NavigationAgent2D").target_position = Vector2(55,650)
		aria.free_later = true
		aria.prev_state = aria.State.MOVE_TO_TARGET
		add_child(aria)
		Dialogic.VAR.set("aria_last_convo",true)
		await Dialogic.start("Aria")
		#aria.move_to()
		#
		Tutorials.tutorials["temp_regulator_tutorial"]=true


func _on_exit_body_entered(body: Node2D) -> void:
	if !body.name =="Farmer":
		return
	if Global.day_count >= 2 and !TaskManager.tasks["Task5"]["acquired"]:
		Dialogic.VAR.set("sera_talk",true)
		Dialogic.start("GeneralMessages")
		return
	print("LEAVE  FARM")
	var time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	Global.player_pos = Vector2(-663,725)
	Global.player_direction.y=-1
	Global.load_frontyard=true
	Global.music_fade_out()
	get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)

func _timeline_ended():
	Dialogic.VAR.set("sera_talk",false)
	if aria!=null:
		Dialogic.start("TempRegulatorTutorial")	
		aria.move_to()
	if sera!=null:
		sera.move_to()
