extends Node2D


var farmer
var inventory
var date_label
var farmer_added=false
var camera
var time_manager
var pause_menu
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")

func _ready() -> void:
	#print("house running")
	farmer=get_node("Farmer")
	get_node("Farmer/TimeManager").queue_free()
	get_node("Farmer/DateLabel").queue_free()
	pause_menu=get_node("Farmer/PauseMenu")
	pause_menu.queue_free()
	get_node("Farmer/Inventory").queue_free()
	time_manager=get_node("TimeManager")

	camera=farmer.get_node("Camera2D")
	camera.queue_free()
	
	farmer.get_node("AnimatedSprite2D").play("backward")

	var inventory= get_tree().current_scene.find_child("Inventory")
	
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
