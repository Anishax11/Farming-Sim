extends Node2D


const INVENTORY = preload("res://scenes/inventory.tscn")
var farmer
var inventory
var date_label
var farmer_added=false


func _ready() -> void:
	#print("house running")
	farmer=get_node("Farmer")
	inventory=INVENTORY.instantiate()
	
	farmer.add_child(inventory)

	date_label=farmer.get_node("DateLabel")
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
				inventory.add_to_inventory(string,null)
				
	
	farmer_added=true


func _on_bed_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	 


func _on_bed_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_dont_sleep_button_down() -> void:
	get_node("/root/house_interior/bed/Label").visible=false
	get_node("/root/house_interior/bed/Sleep").visible=false
	get_node("/root/house_interior/bed/Don't_Sleep").visible=false
