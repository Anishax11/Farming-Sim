extends CharacterBody2D

var menu
var farmer

func _ready() -> void:
	menu = get_tree().current_scene.find_child("VendorMenu",true,false)
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	
	
func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			
			
			#print("DIalogic PRoof of worth done : ",Dialogic.VAR.get("proof_of_worth_done"))	
			Dialogic.VAR.set("proof_of_worth_task_given",TaskManager.tasks["Task4"]["acquired"])			
			get_node("Farmer").input_disabled=true
			Dialogic.signal_event.connect(_on_dialogic_signal)
			Dialogic.VAR.set("cashier_intro",Tutorials.interactions["seed_shop_first_interaction"])	
			#print("Start dialogue")
			#print("Cashier intro :",Dialogic.VAR.cashier_intro,Tutorials.interactions["seed_shop_first_interaction"])
			Dialogic.start("SeedShopOwner")
			if !Tutorials.interactions["seed_shop_first_interaction"]:
				Tutorials.interactions["seed_shop_first_interaction"]=true
			
			#print("DIalogic PRoof of worth done : ",Dialogic.VAR.get("proof_of_worth_done"))	
			
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			menu.visible=true


func _on_dialogic_signal(argument : String):
	if argument=="OpenMenu":
		menu.visible=true
	
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
