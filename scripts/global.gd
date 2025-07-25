extends Node

var day_count=1
var day_passed=false
var inventory_items=[]
var seeds_image
var watercan_image=preload("res://16x16/Sprites/water can icon.png")
var strawberry_image=preload("res://16x16/Sprites/ChatGPT Image Jul 9, 2025, 08_41_42 PM (1).png")
var potato_image=preload("res://16x16/Sprites/ChatGPT Image Jul 13, 2025, 11_20_49 AM.png")
var grass_clicked=false
var grass_held=false
var soil_clicked=false
var panel_clicked=false
var player_direction
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
	
func get_direction(direction) :
	
	player_direction=direction
	#print("player_direction",player_direction)

func move_item(panel_number,item_name):
	var current_scene = get_tree().current_scene
	var texture_rect
	var prev_panel_path
	var final_panel_path
	#print("FUNC Item",item_name,panel_number)
	var inv=get_node("/root/Game/farm_scene/Farmer/Inventory")
	#print(inv.inventory_items)
	#Gets texture node from initial panel
	#if get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/texture")!=null:
		#print("can find text in inial panel")
	#print("panel_number",panel_number)
	#print("item_name",item_name)
	#
	if current_scene==get_node("/root/Game"):
		prev_panel_path="/root/Game/farm_scene/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(panel_number)
		texture_rect=get_node(prev_panel_path+"/"+item_name)
		
	else:
		prev_panel_path="/root/house_interior/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)
		texture_rect=get_node(prev_panel_path+"/"+item_name)
		
		
	var final_panel=round(texture_rect.position.y / 40)*5+round(texture_rect.position.x / 40)+panel_number
	if current_scene==get_node("/root/Game"):
		final_panel_path="/root/Game/farm_scene/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)
	else:
		final_panel_path="/root/house_interior/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)
	#removes texture child from initial panel
	if item_out_of_inv==true:
		
		texture_rect.position=Vector2(0,0)
		item_out_of_inv=false
		return
	
	get_node(prev_panel_path).remove_child(texture_rect)
	
	#if current_scene==get_node("/root/Game"):
		#get_node(prev_panel_path).remove_child(texture_rect)
	#else:
		#get_node("/root/house_interior/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)).remove_child(texture_rect)
	#REMOVE ITEM FROM ARRAY
	
	Global.inventory_items[int((panel_number-1)/5)][(panel_number-1)%5]=""
	
	#print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/texture"))
	#print("panels moved x:", round(texture_rect.position.x / 40))
	
	
	#print("X:",texture_rect.position.x)
	#print("Y:",texture_rect.position.y)
	#print("y increment:",round(texture_rect.position.y / 40)*5)
	#print("Finale panel:",final_panel)
	if get_node("/root/Game/farm_scene/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)+item_name)==null and final_panel>0 and final_panel<16:
		#print("NOT OCCUPIED")
		get_node(final_panel_path).add_child(texture_rect)
		
		#ADD ITEM TO ARRAY
		Global.inventory_items[int((final_panel-1)/5)][int(final_panel-1)%5]=item_name
		
		texture_rect.global_position=get_node(final_panel_path).global_position
		
		
	else:
		#print("OCCUPIED")
		get_node(prev_panel_path).add_child(texture_rect)
		texture_rect.global_position=get_node(prev_panel_path).global_position
		Global.inventory_items[int((panel_number-1)/5)][int(panel_number-1)%5]=item_name
	
	
	
	
	#print("Text final path:",texture_rect.get_path())
	#
	#print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).position)
	
func get_empty_panel():
	return empty_panel

var plant_number=1
var plant_stages_index=0

func grow_plant(soil_name):
	var soil =get_node("/root/Game/farm_scene/SoilManager/"+soil_name)
	var plant=PLANT.instantiate()
	plant.scale=Vector2(0.2,0.2)
	#print("Last plnt index in dic:",PlantTracker.plant_stages.size()-1)

	plant.name=PlantTracker.plant_names[soil_name]
	
	#print("Gobal plant name:",plant.name)

	#soil.remove_child.soil.get_node("AnimatedSprite2D")
	#get_node("/root/Game/farm_scene/").add_child(plant)
	if get_node("/root/Game/farm_scene/"):
		#get_node("/root/Game/farm_scene/").add_child(plant)
		
		soil.add_child(plant)
		
		#PlantTracker.add_to_plant_dictionary(plant.name)
		#print("Plant added to farm_scene")
		soil.get_node("AnimatedSprite2D").play("rect_tilled")
		plant.global_position.y=soil.global_position.y-5
		#plant.global_position.x=soil.global_position.x-8
		plant.global_rotation=0
	#else:
		#print("farm_scene not found!")
		
	
	
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
	#print("Updated day")
	day_count+=1
	day_passed=true

func plant_watered(node):
	watered_plants.append(node.name)
	#print(watered_plants)
	
var current_time
var time_to_change_tint
var tint_index	

func track_time(time,change_time,index):
	#print("saved time")
	current_time=time
	time_to_change_tint=change_time
	tint_index=index
	
