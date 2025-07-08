extends Node2D

const FARMER = preload("res://scenes/farmer.tscn")
const INVENTORY = preload("res://scenes/inventory.tscn")
var farmer
var inventory

func _ready() -> void:
	print("house running")
	farmer=FARMER.instantiate()
	inventory=INVENTORY.instantiate()
	farmer.add_child(inventory)
	inventory.visible=false
	for i in range (3):
		for j in range (5):
			var string=Global.inventory_items[i][j]
				
			if string!="":
				Global.inventory_items[i][j]=""
				inventory.add_to_inventory(string,Global.seeds_image)
	add_child(farmer)
	
