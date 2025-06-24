extends Node2D
var i
var j
var inventory_items=[]
var slot_found=false
var slots_passed=0
var slot_adjust=1
var seeds=preload("res://16x16/Sprites/ChatGPT Image Jun 22, 2025, 01_37_12 AM.png")



func _ready() -> void:
	for i in range(3):
		inventory_items.append([])
		for j in range(5):
			inventory_items[i].append("")
			
	#inventory_items[0][1]="seeds"
	#inventory_items[0][0]="seeds"
	#add_to_inventory("seeds")
	#print(inventory_items)

func add_to_inventory(string):
	
	for i in range(3):
			
		for j in range(5):
			print(i,",",j)
			if inventory_items[i][j]=="":
				print("slot availabke")
				inventory_items[i][j]=string
				var texture=TextureRect.new()
				texture.texture=seeds
				texture.name="texture"
				texture.scale.x=0.016
				texture.scale.y=0.016
				print("Slot passed:",slots_passed)
				print("ADJ:",slot_adjust)
				print("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
				get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust)).add_child(texture)
				texture.z_index=1
				slot_found=true
				print("slot_found:",slot_found)
				
				slots_passed=0
				slot_adjust=1
				print(inventory_items)
				return
			elif i==2 and j==4:
				print("Inventory is full")	
			
		slots_passed+=5
		slot_adjust-=1		
				
