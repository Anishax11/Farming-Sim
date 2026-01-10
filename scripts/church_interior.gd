extends Node2D
@onready var dial := get_node("LabelCanvas/DialDisplay/TextureRect")

func _on_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			dial.pivot_offset = dial.size / 2
			dial.rotation+=45
