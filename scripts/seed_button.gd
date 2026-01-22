extends Button

var seed_type
var price
var player
var empty_panel
var inv
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	print("Here ...........")
	mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
	player=get_node("/root/SeedShopInterior/Farmer")
	inv = get_tree().current_scene.find_child("Inventory",true,false)
	
func _on_button_down() -> void:
	
	
	if inv.full:
		print("Inv full!")
		Dialogic.VAR.set("inv_full",true)
		Dialogic.start("GeneralMessages")
		return
	print("Buy button clicked")
	seed_type=get_parent().seed_type
	print("Seed_Type:",seed_type)
	
	#print("Parent: "+ get_parent().name)
	#visible=false
	#for sibling in get_parent().get_children():
		#if sibling != self and !sibling is TextureRect and !sibling is CollisionShape2D:
			#print(sibling.name)
			#get_parent().seed_type = sibling.text
	
	if seed_type!=null:
		#if seed_type=="strawberry":
			#price=100
		#elif seed_type=="potato":
			#price=50
		#elif seed_type=="pumkin":
			#price=80
		
		price = PlantTracker.prices[seed_type]
		if (price > Global.coins_count):
			print("Insufficient coins")
			return
		print("SEED TYPE :",seed_type)
		
			
		print("BUYING SEEDS....")
		#while texture_rect == null:
				#await get_tree().process_frame
		   		#
		player.update_coins(-price)
		var inventory= get_tree().current_scene.find_child("Inventory")
		if !TaskManager.tasks["Task8"]["completed"]:
			TaskManager.tasks["Task8"]["completed"] = true
			get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task8")
			Dialogic.start("InventoryTutorial")
	
	
		
		inventory.add_to_inventory(seed_type+"_seeds",Global.strawberry_image)
		empty_panel = Global.get_empty_panel()
		PlantTracker.panel_info[empty_panel.name]["seed_count"]=6
		print("Empty panel : ",empty_panel.name)				
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		#print("Global.empty_panel:",Global.empty_panel.name)
		#Global.empty_panel.seed_count=6
		get_parent().queue_free()
				
	else:
		print("SEED TYPE  null")			
				
				
func _on_timeline_ended():
	Dialogic.VAR.set("inv_full",false)
