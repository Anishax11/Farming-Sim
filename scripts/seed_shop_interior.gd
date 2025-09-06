extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("DIsplay menu 1")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			print("DIsplay menu")
			get_node("VendorMenu").visible=true#! get_node("VendorMenu").visible


func _ready() -> void:
	print("READT")
	#connect("input_event", Callable(self, "_input_event"))
#
	##get_node("VendorMenu").mouse_filter = Control.MOUSE_FILTER_IGNORE
#
#func _input_event(viewport, event, shape_idx):
	#print("DIsplay menu 1")
	#print("Got input on Area2D:", event)
	
