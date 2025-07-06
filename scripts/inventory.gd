extends Node2D
var i
var j

var slot_found=false
var slots_passed=0
var slot_adjust=1
var inv_initialised=false



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
	
	for i in range(3):
			
		for j in range(5):
			print(i,",",j)
			if Global.inventory_items[i][j]=="":
				print("slot available")
				Global.inventory_items[i][j]=string
				#var texture=TextureRect.new()
				#texture.texture=item_texture
				#texture.name="texture"
				
				#print("Slot passed:",slots_passed)
				#print("ADJ:",slot_adjust)
				#print("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
				
				Global.empty_panel=get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
				print("Empty panel:",Global.empty_panel)
				
				
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
				
