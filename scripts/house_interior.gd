extends Node2D


var farmer
var inventory
var date_label
var farmer_added=false
var time_manager
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
var sleep_confirmation
#@onready var camera_2d: Camera2D = $Camera2D


func _ready() -> void:
	print("house running")
	#Global.music_fade_in()
	Dialogic.end_timeline()
	farmer=get_node("Farmer")
	var camera_2d = farmer.get_node("Camera2D")
	#camera.queue_free()
	
	camera_2d.limit_bottom = 1250
	camera_2d.limit_top = -45
	camera_2d.limit_left = 0
	camera_2d.limit_right = 2060
	camera_2d.zoom=Vector2(1,1)

	
	get_node("Farmer/ClickBlocker").queue_free()
	#get_node("Farmer/TaskManager").queue_free()
	time_manager=get_tree().get_current_scene().find_child("TimeManager")
	#print("Task acq :",tasks["Task1"]["acquired"])
	
	#camera=farmer.get_node("Camera2D")
	#camera.queue_free()
	
	farmer.get_node("AnimatedSprite2D").play("backward")

	var inventory= get_tree().current_scene.find_child("Inventory")
	sleep_confirmation = get_tree().current_scene.find_child("SleepConfirmation",true,false)
	
	#for i in range (3):
		#for j in range (5):
			#var string=Global.inventory_items[i][j]
				#
			#if string!="":
				#Global.inventory_items[i][j]=""
				#inventory.add_to_inventory(string,null)
				#
	
	farmer_added=true


func _on_bed_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	 


func _on_bed_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_dont_sleep_button_down() -> void:
	print("DOnt sleep")
	sleep_confirmation.visible=false
	



func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y!=1:
		return
	print("Exit House")
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	Global.player_pos = Vector2(120,505)
	Global.music_fade_out()
	await get_tree().change_scene_to_packed(FRONTYARD_SCENE)


func _on_button_button_down() -> void:
	print("Test button working")
