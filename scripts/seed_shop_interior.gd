extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")
var MARKET_PLACE = load("res://scenes/market_place.tscn")
var time_manager

	#print("DIsplay menu 1")
	

func _ready() -> void:
	Global.music_fade_in()
	#Dialogic.end_timeline()
	
	Dialogic.VAR.set("proof_of_worth_done",TaskManager.tasks["Task4"]["completed"] )
	print("Tutorials.tutorial",Tutorials.tutorials["seed_shop_tutorial"])
	if !Tutorials.tutorials["seed_shop_tutorial"]:
		print("Inside ")
		await Dialogic.start("SeedShopTutorial")
		Tutorials.tutorials["seed_shop_tutorial"]=true
	for character in TaskManager.task_status["top_5"]:
				if character.name == "Player":
					Dialogic.VAR.set("proof_of_worth_done",true)
					print("PRoof of worth done")
	print("DIalogic PRoof of worth done : ",Dialogic.VAR.get("proof_of_worth_done"))	
	get_node("Farmer/ClickBlocker").queue_free() #holds inv

	get_node("Farmer/Camera2D").queue_free()
	
	
	get_node("Farmer/AnimatedSprite2D").play("backward")
	Global.player_direction=Vector2(0,0)
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	
		
		
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name!= "Farmer":
		return
	if Global.player_direction.y==1:
		print("LEAVING SHOP")
		Global.player_pos=Vector2(125,-50)
		Dialogic.end_timeline()
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		#Global.current_time = time_manager.current_time
		#Global.time_to_change_tint = time_manager.time_to_change_tint
		#Global.tint_index = time_manager.color_rect.i
		Global.music_fade_out()
		get_node("CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)



	
	

func _on_dialogic_signal(argument : String):
	if argument=="OpenMenu":
		get_node("VendorMenu").visible=true
	
	elif argument=="proof_of_worth_task_given":
		TaskManager.tasks["Task4"]["acquired"] = true
		if !TaskManager.tasks["Task4"]["completed"]:
			get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task4")
	
	elif argument=="proof_of_worth_done":
		TaskManager.tasks["Task4"]["completed"] = true	
		if TaskManager.tasks["Task4"]["acquired"] == true :
			get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task4")
		Dialogic.VAR.set("proof_of_worth_done",true )
	
	elif argument =="enable_movement":
		get_node("Farmer").input_disabled=false

func _on_close_menu_button_down() -> void:
	print("Closing menu ")
	get_node("VendorMenu").visible=false


#func _on_mouse_entered() -> void:
	#print("Mouse entered")
	#Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

#func _on_mouse_exited() -> void:
	#Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_cashier_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_cashier_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_cashier_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			
			if !Tutorials.interactions["seed_shop_first_interaction"]:
				Tutorials.interactions["seed_shop_first_interaction"]=true
			print("DIalogic PRoof of worth done : ",Dialogic.VAR.get("proof_of_worth_done"))	
			Dialogic.VAR.set("proof_of_worth_task_given",TaskManager.tasks["Task4"]["acquired"])			
			get_node("Farmer").input_disabled=true
			Dialogic.signal_event.connect(_on_dialogic_signal)
			Dialogic.start("SeedShopOwner")
			Dialogic.VAR.set("cashier_intro",Tutorials.interactions["seed_shop_first_interaction"])	
			print("DIalogic PRoof of worth done : ",Dialogic.VAR.get("proof_of_worth_done"))	
			
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_node("VendorMenu").visible=true


func _on_button_button_down() -> void:
	print("Button down")
