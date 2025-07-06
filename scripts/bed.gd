extends Area2D

var game = load("res://scenes/game.tscn")
var sleep_button
var dont_sleep_button

func _ready() -> void:
	print("int just loaded:",Global.tilled_soil)
	sleep_button=get_node("Sleep")
	dont_sleep_button=get_node("Don't_Sleep")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_node("Label").text="GO TO SLEEP?" 
			sleep_button.visible=true
			dont_sleep_button.visible=true



#EXIT BUTTON
func _on_button_button_down() -> void:
	
	await get_tree().change_scene_to_packed(game)
	Global.load_farm=true

#SLEEP BUTTON
func _on_sleep_button_down() -> void:
	Global.update_day_count()
