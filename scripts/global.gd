extends Node

const HOUSE_INTERIOR = preload("res://scenes/house_interior.tscn")
#PLAYER ABILITIES:
var coherence = 3  #reset to 3 everyday
var entropy = 3    #reset to 3 everyday
##
var freeze_time = false
var day_count=1
var day_passed=false
var inventory_items=[]
var seeds_image=preload("res://16x16/Sprites/seeds_packet_16x16.png")
var strawberry_seeds_image=preload("res://16x16/Sprites/Strawberry_seeds.png")
var potato_seeds_image=preload("res://16x16/Sprites/Potato_seeds.png")
var pumpkin_seeds_image=preload("res://16x16/Sprites/Pumpkin_seeds.png")
var special_seeds_image = preload("res://16x16/Sprites/Pumpkin_seeds.png")
var watercan_image=preload("res://16x16/Sprites/Watercan.png")
var strawberry_image=preload("res://16x16/Sprites/Strawberry.png")
var potato_image=preload("res://16x16/Sprites/Potato.png")
var pumpkin_image = preload("res://16x16/Sprites/Pumpkin.png")
var special_image = preload("res://16x16/Sprites/Potato.png") #specail plant
var grass_clicked=false
var grass_held=false
var soil_clicked=false
var panel_clicked=false
var player_direction = Vector2(0,0)
var panel_number
var item_out_of_inv=false
var seeds_texture
var watercan_texture
var empty_panel
var tilled_soil:Array=[]
var tilled_soil_animation:Array=[]
var sown_soil:Array=[]
var sown_soil_animation:Array=[]
var planted_soil:Array=[]
var tilled_soil_index=0
var load_farm=false
var load_house=false
var seeds_initialised=false
var watered_plants=[]
var fully_grown_plant_soil=[]
const PLANT = preload("res://scenes/plant.tscn")
const HIGHLIGHTED_PANEL = preload("res://16x16/Sprites/highlighted_panel_image.jpg")
const INVENTORY_SLOT = preload("res://16x16/Sprites/inventorySlot.png")
var equipped_item
var last_plant_number
var load_frontyard=false
var coins_count=50
var color_rect_i=0
var soil_data={
	
}
var player_pos #used to set player location after instantiating new scene
var ItemPriceList={
	"strawberry_seeds": 100,
	"potato_seeds" : 50,
	"pumpkin_seeds" : 200,
	"special_seeds" : 300,
	"watercan" : 100,
	"strawberry" : 50,
	"potato" : 225,
	"pumpkin" : 100,
	"special" : 400
	
}

var trade_money=0
var equipped_panel #Keeps track of equipped panel
#var win_size
#func _ready():
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

	
func _input(event):
	var pause_menu = get_tree().current_scene.find_child("PauseMenu",true,false)
	if event.is_action_pressed("Escape") :
		if pause_menu.visible:
			pause_menu.visible = false 
			return
		print("Esc")
		get_tree().paused=!get_tree().paused
		pause_menu.visible=!pause_menu.visible
		print("Esc COmplete")
		
func get_direction(direction) :
	
	player_direction=direction
	#print("player_direction",player_direction)

func move_item(panel_number,item_name):
	print("MOve item called on : "+item_name)
	var current_scene = get_tree().current_scene
	var panel_name ="Panel"+str(panel_number)
	var previous_panel = get_tree().get_current_scene().find_child(panel_name, true, false)
	var texture_rect = previous_panel.get_node(NodePath(item_name))
	
	if texture_rect==null:
		print("Texture_rect nulll")
		
	var inv=get_tree().get_root().find_child("Inventory", true, false)
	#print(inv.inventory_items)

	var final_panel_number=round(texture_rect.position.y / 40)*5+round(texture_rect.position.x / 40)+panel_number
#
	var final_panel_name="Panel" + str(final_panel_number) 
	var final_panel = 	get_tree().get_current_scene().find_child(final_panel_name, true, false)
	
	if final_panel==null:
		print("Final panel is null")
		previous_panel.add_child(texture_rect)
		texture_rect.global_position=previous_panel.global_position
		Global.inventory_items[int((panel_number-1)/5)][int(panel_number-1)%5]=item_name
		return
	
	print("Final panel no :",final_panel_number)	
	if final_panel.item_name==null and final_panel_number>0 and final_panel_number<16:
		print("NOT OCCUPIED")
		if final_panel!=previous_panel:
			print("final_panel!=previous_panel")
			final_panel.item_name = previous_panel.item_name
			final_panel.seed_type=previous_panel.seed_type
			final_panel.seed_count=previous_panel.seed_count
			final_panel.score=previous_panel.score
			final_panel.clicked=previous_panel.clicked
			PlantTracker.panel_info[final_panel.name]["seed_count"]=previous_panel.seed_count
			PlantTracker.panel_info[previous_panel.name]["seed_count"]=0
			previous_panel.seed_count=0 
			previous_panel.score=null
			previous_panel.clicked = false
			previous_panel.remove_item()
			#texture_rect.name=previous_panel.item_name
			#previous_panel.item_name=null
			final_panel.add_child(texture_rect)
			
			Global.inventory_items[int((final_panel_number-1)/5)][int(final_panel_number-1)%5]=item_name
			
			texture_rect.global_position=final_panel.global_position
			texture_rect.z_index = 1
			#print("Text z :",texture_rect.z_index ," panel z : ",final_panel.z_index)
			
			#REMOVE ITEM FROM ARRAY
			Global.inventory_items[int((panel_number-1)/5)][(panel_number-1)%5]=""
			
			#Highligh new panel if dropped item  is equipped
			if Global.equipped_panel == previous_panel.name:  
				print("equipped item moved,Highlight panel new panel")
				Global.equipped_panel = final_panel.name
				final_panel.item_name = item_name
				
				print("Final panel equipped:",final_panel.name," item :",final_panel.item_name)
				final_panel.highlight_panel()
		
			
	else:
		print("OCCUPIED")
		if final_panel!=previous_panel:
			print("New Panel occupied")
			previous_panel.add_child(texture_rect)
			texture_rect.global_position=previous_panel.global_position
			Global.inventory_items[int((panel_number-1)/5)][int(panel_number-1)%5]=item_name
		
		else: # item is clicked, stays in same panel
			if final_panel.item_name!=null:
				equipped_panel = final_panel.name
				print("Item clicked : ",final_panel.clicked)
				final_panel.clicked=!final_panel.clicked
				if final_panel.clicked==false:
					equipped_panel=null
					print("equipped panel null")
				equipped_panel = final_panel.name
				var last_five = final_panel.item_name.substr(item_name.length() - 5, 5)
				if last_five=="seeds" and final_panel.get_child(0)!=null :
					print("Item is seeds")
				#print(get_child(0).name)
				#print(get_child(0).visible)
				#
					if final_panel.water_equipped==true:
						final_panel.water_equipped=false
						
					final_panel.seeds_equipped=!final_panel.seeds_equipped
					
					print("seeds_equipped :",final_panel.seeds_equipped)
					
					equip_item(final_panel.seed_type)
			#else:
				#print("Item is not seeds")	
				
				if final_panel.item_name=="watercan":
					if final_panel.seeds_equipped==true:
						final_panel.seeds_equipped=false
					#print("Item is water")
					final_panel.water_equipped=!final_panel.water_equipped
	#print("Text final path:",texture_rect.get_path())
	#
	#print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).position)
	
func get_empty_panel():
	return empty_panel

var plant_number=1
var plant_stages_index=0

func grow_plant(soil_name):
	var soil =get_node_or_null("/root/farm_scene/SoilManager/"+soil_name)
	var plant=PLANT.instantiate()
	plant.scale=Vector2(0.4,0.4)
	#print("Last plnt index in dic:",PlantTracker.plant_stages.size()-1)

	plant.name=PlantTracker.plant_names[soil_name]
	
	print("Gobal plant name:",plant.name)
	#soil.remove_child.soil.get_node("AnimatedSprite2D")
	#get_node("/root/Game/farm_scene/").add_child(plant)
	if soil==null:
		print("SOil is null")
	
	if get_node_or_null("/root/farm_scene")!=null:
		#get_node("/root/Game/farm_scene/").add_child(plant)
		soil.add_child(plant)
		
		#PlantTracker.add_to_plant_dictionary(plant.name)
		print("Plant added to farm_scene")
		soil.get_node("AnimatedSprite2D").play("rect_tilled")
		plant.global_position.y=soil.global_position.y-5
		#plant.global_position.x=soil.global_position.x-8
		plant.global_rotation=0
	else:
		print("farm_scene not found!")
		
	
	
func save_tilled_soil(soil,animation):
	if soil.tilled!=true and soil.planted!=true:
		tilled_soil.append(soil.name)
		tilled_soil_animation.append(animation)
		tilled_soil_index+=1
	elif soil.planted==true:
		sown_soil.append(soil.name)
		#print("Added to array")
		sown_soil_animation.append(animation)
		
		
func update_day_count():
	print("Update day")
	day_count+=1
	Dialogic.VAR.set("day",day_count)
	print("DAy updated :",Dialogic.VAR.day)
#date_label.update_day_count()
	time_to_change_tint=8.00
	tint_index=0
	current_time=6.00
	minutes = 00
	TaskManager.task_status["lock_counter"]=false
	#time_passed=0.0
	#initial_time=0.0
	coherence = 3
	entropy = 3	
	await get_tree().change_scene_to_packed(HOUSE_INTERIOR)	
	while(get_node("/root/house_interior/Farmer")==null):
		await get_tree().process_frame  # wait for the scene to finish loading
	
	#Global.watered_plants.clear()
	PlantTracker.locked_growth.clear() # plants in this array have been watered once(used to ensure plant stage is incremented only once per day )
	day_passed=true
	if trade_money>0:
		print("Increment coins")
		get_node("/root/house_interior/Farmer").update_coins(trade_money)
		
		trade_money=0

func plant_watered(node):
	watered_plants.append(node.name)
	#print(watered_plants)
	
var current_time=6.00
var minutes = 00
var time_to_change_tint=6.00
var tint_index=0	

func track_time(time,change_time,index,minutes_passed):
	#print("saved time")
	current_time=time
	time_to_change_tint=change_time 
	tint_index=index
	minutes=minutes_passed

func equip_item(item_name):
	print("EQUIPPED: "+item_name)
	equipped_item=item_name


func music_fade_out():
	print("Fade out")
	var audio_player =  get_tree().get_current_scene().find_child("BGMusic", true, false)
	var player = get_tree().get_current_scene().find_child("Farmer", true, false)
	var tween=create_tween()
	tween.tween_property(audio_player,"volume_db",-40,7)
	await tween.finished

var music_tween_finished=false	

func music_fade_in():	
	print("Fade out")
	var audio_player =  get_tree().get_current_scene().find_child("BGMusic", true, false)
	var player = get_tree().get_current_scene().find_child("Farmer", true, false)
	var tween=create_tween()
	tween.tween_property(audio_player,"volume_db",-20,7)
	#await tween.finished
