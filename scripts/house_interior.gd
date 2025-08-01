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
	add_child(date_label)
	date_label.position=Vector2(1350,-1350)
	date_label.scale.x=3
	date_label.scale.y=3
	#farmer.add_child(date_label)
	farmer.scale.x=50
	farmer.scale.y=50
	farmer.get_node("AnimatedSprite2D").play("backward")

	inventory.scale = Vector2(2.0 / farmer.scale.x, 2.0 / farmer.scale.y)
	inventory.visible=false
	inventory.position=Vector2(5,-8)
	
	farmer.position=Vector2(-1000,1500)
	for i in range (3):
		for j in range (5):
			var string=Global.inventory_items[i][j]
				
			if string!="":
				Global.inventory_items[i][j]=""
				inventory.add_to_inventory(string,Global.seeds_image)
	add_child(farmer)
	farmer_added=true


func _on_bed_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	 


func _on_bed_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
