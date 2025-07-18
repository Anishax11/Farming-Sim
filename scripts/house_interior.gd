extends Node2D

const FARMER = preload("res://scenes/farmer.tscn")
const INVENTORY = preload("res://scenes/inventory.tscn")
var farmer
var inventory
var date_label
var farmer_added=false
const DATE_LABEL = preload("res://scenes/date_label.tscn")
func _ready() -> void:
	#print("house running")
	farmer=FARMER.instantiate()
	inventory=INVENTORY.instantiate()
	date_label=DATE_LABEL.instantiate()
	farmer.add_child(inventory)
	farmer.add_child(date_label)
	inventory.visible=false
	for i in range (3):
		for j in range (5):
			var string=Global.inventory_items[i][j]
				
			if string!="":
				Global.inventory_items[i][j]=""
				inventory.add_to_inventory(string,Global.seeds_image)
	add_child(farmer)
	farmer_added=true
