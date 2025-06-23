extends Node

var grass_clicked=false
var soil_clicked=false
var panel_clicked=false
var player_direction
var panel_number
var item_out_of_inv=false


#func till_soil(player):
	
	#if abs(position-location)<=16:
		#queue_free()

	
func get_direction(direction) :
	player_direction=direction
	#print("player_direction",player_direction)

func move_item(panel_number):
	
		
	#Gets texture node from initial panel
	var texture_rect=get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/texture")
	#print("INI:","/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/TextureRect")
	#removes texture child from initial panel
	if item_out_of_inv==true:
		texture_rect.position=Vector2(0,0)
		item_out_of_inv=false
		return
	get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)).remove_child(texture_rect)
	print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel" +str(panel_number)+"/TextureRect"))
	#print("panels moved x:", round(texture_rect.position.x / 40))
	var final_panel=round(texture_rect.position.y / 40)*5+round(texture_rect.position.x / 40)+panel_number
	print("Finale panel:",final_panel)
	get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).add_child(texture_rect)
	print(texture_rect.get_path())
	texture_rect.global_position=get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).global_position
	print(get_node("/root/Game/Farmer/Inventory/NinePatchRect/GridContainer/Panel"+str(final_panel)).position)
