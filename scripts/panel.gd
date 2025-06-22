extends Panel

@onready var texture_rect: TextureRect = $TextureRect
	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			#print("Clicked panel")
			#print(texture_rect)
			Global.panel_clicked=!Global.panel_clicked
		elif ! event.pressed:
			print("Left button")
