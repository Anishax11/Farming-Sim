extends Node2D

var inventory_items=[]
var slot_found=false
var slots_passed=0
var slot_adjust=1
func _ready() -> void:
	for i in range(3):
		inventory_items.append([])
		for j in range(5):
			inventory_items[i].append("seeds")
			
	inventory_items[1][3]=""
	add_to_inventory("seeds")
	print(inventory_items)

func add_to_inventory(string):
	
	for i in range(3):
		if slot_found:
			slot_found=false
			break
		for j in range(5):
			if inventory_items[i][j]=="":
				inventory_items[i][j]=string
				print(get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust)).get_path())
				slot_found=true
				break
		slots_passed+=5
		slot_adjust-=1	
				
