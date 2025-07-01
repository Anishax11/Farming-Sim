extends Area2D

var game = load("res://scenes/game.tscn")


func _ready() -> void:
	print("int just loaded:",Global.tilled_soil)



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_node("Label").text="GO TO SLEEP?" 
			


#func _on_button_pressed() -> void:
	#


func _on_button_button_down() -> void:
	print("EXIT")
	print("before load:",Global.tilled_soil)
	await get_tree().change_scene_to_packed(game)
	Global.load_farm=true
	print("After load:",Global.tilled_soil)
 	
	print("EXIT")
