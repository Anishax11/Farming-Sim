extends Node2D


const INVENTORY = preload("res://scenes/inventory.tscn")
var farmer
var inventory
var date_label
var farmer_added=false
var camera
var time_manager
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")

func _ready() -> void:
	#print("house running")
	farmer=get_node("Farmer")
	get_node("Farmer/TimeManager").queue_free()
	get_node("Farmer/DateLabel").queue_free()
	get_node("Farmer/Inventory").position.y=-80
	get_node("Farmer/Inventory").scale=Vector2(0.3,0.5)
	time_manager=get_node("TimeManager")
	#time_manager=farmer.get_node("TimeManager")
	inventory=farmer.get_node("Inventory")
	camera=farmer.get_node("Camera2D")
	camera.queue_free()
	#date_label=farmer.get_node("DateLabel")
	#date_label.global_position=Vector2(1400,-5)
	#time_manager.global_position=Vector2(0,50)
	#date_label.add_theme_font_size_override("font_size", 10)
	#time_manager.get_node("Label").add_theme_font_size_override("font_size", 12)
	##date_label.scale.y=50
	#date_label.visible=true
	#farmer.add_child(date_label)
	#farmer.scale.x=50
	#farmer.scale.y=50
	farmer.get_node("AnimatedSprite2D").play("backward")

	inventory.scale = Vector2(2.0 / farmer.scale.x, 2.0 / farmer.scale.y)
	inventory.visible=false
	inventory.position=Vector2(5,-8)
	
	
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



func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y!=1:
		return
	print("Exit House")
	Global.current_time=time_manager.current_time
	Global.time_to_change_tint=time_manager.time_to_change_tint
	Global.tint_index=time_manager.color_rect.i
	await get_tree().change_scene_to_packed(FRONTYARD_SCENE)
