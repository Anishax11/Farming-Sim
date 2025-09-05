extends Node2D
var i
var j

var slot_found=false
var slots_passed=0
var slot_adjust=1
var inv_initialised=false
var seeds_count=0


func _ready() -> void:
	for i in range(3):
		Global.inventory_items.append([])
		for j in range(5):
			Global.inventory_items[i].append("")
	inv_initialised=true		
	#inventory_items[0][1]="seeds"
	#inventory_items[0][0]="seeds"
	#add_to_inventory("seeds")
	#print(inventory_items)

func add_to_inventory(string,item_texture) :
	print("Item added to inv:",string)
	if string=="seeds":
		seeds_count+=6
	for i in range(3):
			
		for j in range(5):
			#print(i,",",j)
			if Global.inventory_items[i][j]=="":
			#	print("slot available")
				Global.inventory_items[i][j]=string
				var texture_rect=TextureRect.new()
				texture_rect.texture=Global.get(string+"_image")
				
				texture_rect.name=string
				if Global.get(string+"_image")==null:
					print(string+" is null")
				#print("Slot passed:",slots_passed)
				#print("ADJ:",slot_adjust)
				#print("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
				
				Global.empty_panel=get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
				Global.empty_panel.add_child(texture_rect)
				print("EMPTY PANEL :",Global.empty_panel)
				print("Texture name :",texture_rect.name)
				#texture_rect.global_position=Vector2(Global.empty_panel.global_position.x+2,Global.empty_panel.global_position.y+2)
				#print("Empty panel:",Global.empty_panel.name,Global.empty_panel.get_child(0))
				
				
				#texture.position=Vector2(0,0)
				#texture.z_index=1
				slot_found=true
				#print("slot_found:",slot_found)
				
				slots_passed=0
				slot_adjust=1
				#print(inventory_items)
				return
			elif i==2 and j==4:
				print("Inventory is full")	
			
		slots_passed+=5
		slot_adjust-=1		
				
func remove_item(item_name):
	print("REMOVING ITEM")
	for i in range(3):
		#print(i,",",j)	
		for j in range(5):
			#print(i,",",j)
			if Global.inventory_items[i][j]==item_name:
				Global.inventory_items[i][j]=""
				return
			
