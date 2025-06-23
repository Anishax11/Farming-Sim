extends Node2D

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
		if slot_found==true:
			slot_found=false
			break
		for j in range(5):
			if inventory_items[i][j]=="":
				inventory_items[i][j]=string
				var texture=TextureRect.new()
				texture.texture=seeds
				
				texture.scale.x=0.016
				texture.scale.y=0.016
				get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust)).add_child(texture)
				slot_found=true
				break
		slots_passed+=5
		slot_adjust-=1	
				
