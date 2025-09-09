extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("DIsplay menu 1")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			
			get_node("VendorMenu").visible=!get_node("VendorMenu").visible


func _ready() -> void:
	print(get_path())
	
#
	##get_node("VendorMenu").mouse_filter = Control.MOUSE_FILTER_IGNORE

	
