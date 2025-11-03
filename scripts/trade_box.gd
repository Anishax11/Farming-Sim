extends Area2D



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT  and event.pressed:
		if !Tutorials.trade_box_tutorial:
			await Dialogic.start("TradeBoxTutorial")
			Tutorials.trade_box_tutorial=true
		get_node("TradeInventory").visible=true
