extends Area2D
var FARM_SCENE = load("res://scenes/farm_scene.tscn")
var game = load("res://scenes/game.tscn")
var sleep_button
var dont_sleep_button
var time_manager
var color_rect
const HOUSE_INTERIOR = preload("res://scenes/house_interior.tscn")
var sleep_confirm
func _ready() -> void:
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	#print("int just loaded:",Global.tilled_soil)
	color_rect=get_parent().get_node("CanvasLayer/ColorRect")
	sleep_confirm = get_tree().current_scene.find_child("SleepConfirmation",true,false)
	sleep_button=sleep_confirm.get_node("Sleep")
	dont_sleep_button=sleep_confirm.get_node("Don't_Sleep")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Toggle visibility")
			sleep_confirm.visible=true
			sleep_button.visible=true
			dont_sleep_button.visible=true

#SLEEP BUTTON
func _on_sleep_button_down() -> void:
	print("Sleep")
	Global.update_day_count()
	
