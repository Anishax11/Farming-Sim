extends CharacterBody2D


func _ready() -> void:
	if Global.day_count<5:
		queue_free()



func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
