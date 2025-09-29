extends Area2D
var FARM_SCENE = load("res://scenes/farm_scene.tscn")
var game = load("res://scenes/game.tscn")
var sleep_button
var dont_sleep_button
var time_manager
var color_rect
func _ready() -> void:
	time_manager=get_parent().get_node("Farmer/TimeManager")
	#print("int just loaded:",Global.tilled_soil)
	sleep_button=get_node("Sleep")
	dont_sleep_button=get_node("Don't_Sleep")
	color_rect=get_parent().get_node("Farmer/CanvasLayer/ColorRect")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_node("Label").text="GO TO SLEEP?" 
			sleep_button.visible=true
			dont_sleep_button.visible=true



#EXIT BUTTON
func _on_button_button_down() -> void:
	#Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect_i)
	Global.current_time=time_manager.current_time
	Global.time_to_change_tint=time_manager.time_to_change_tint
	Global.tint_index=time_manager.color_rect.i
	
	await get_tree().change_scene_to_packed(FARM_SCENE)
	Global.load_farm=true

#SLEEP BUTTON
func _on_sleep_button_down() -> void:
	Global.update_day_count()
	Global.current_time=6.0
	Global.time_to_change_tint=8.0
	Global.tint_index=0
	
	time_manager.current_time=6.0
	time_manager.time_to_change_tint=8.0
	color_rect.i=0
