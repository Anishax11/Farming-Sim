extends Node

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
const PLANT = preload("res://scenes/plant.tscn")
	
func get_direction(direction) :
	player_direction=direction
	#print("player_direction",player_direction)

func move_item(panel_number,item_name):
	print("FUNC Item",item_name,panel_number)
	var inv=get_node("/root/Game/Farmer/Inventory")
	#print(inv.inventory_items)
	#Gets texture node from initial panel
	#if get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/texture")!=null:
		#print("can find text in inial panel")
	
	var texture_rect=get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/"+item_name)
	
	#print("INI:","/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/TextureRect")
	#removes texture child from initial panel
	if item_out_of_inv==true:
		
		texture_rect.position=Vector2(0,0)
		item_out_of_inv=false
		return
	get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)).remove_child(texture_rect)
	
	#REMOVE ITEM FROM ARRAY
	
	inv.inventory_items[int((panel_number-1)/5)][(panel_number-1)%5]=""
	
	#print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/texture"))
	#print("panels moved x:", round(texture_rect.position.x / 40))
	
	var final_panel=round(texture_rect.position.y / 40)*5+round(texture_rect.position.x / 40)+panel_number
	#print("X:",texture_rect.position.x)
	#print("Y:",texture_rect.position.y)
	#print("y increment:",round(texture_rect.position.y / 40)*5)
	#print("Finale panel:",final_panel)
	if get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)+item_name)==null and final_panel>0 and final_panel<16:
		#print("NOT OCCUPIED")
		get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).add_child(texture_rect)
		
		#ADD ITEM TO ARRAY
		inv.inventory_items[int((final_panel-1)/5)][int(final_panel-1)%5]=item_name
		
		texture_rect.global_position=get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).global_position
		
		
	else:
		#print("OCCUPIED")
		get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(panel_number)).add_child(texture_rect)
		texture_rect.global_position=get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(panel_number)).global_position
		inv.inventory_items[int((panel_number-1)/5)][int(panel_number-1)%5]=item_name
	
	
	
	
	print("Text final path:",texture_rect.get_path())
	#
	#print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).position)
	
func get_empty_panel():
	return empty_panel

func grow_plant(soil,rotation_degrees):
	print("grow plant Func called")
	var plant=PLANT.instantiate()
	plant.scale=Vector2(0.1,0.1)
	
	#soil.remove_child.soil.get_node("AnimatedSprite2D")
	get_node("/root/Game").add_child(plant)
	
	plant.global_position.y=soil.global_position.y-18
	plant.global_position.x=soil.global_position.x-8
