extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		get_node("VendorMenu").visible=true#! get_node("VendorMenu").visible




	


	#print("BUYING")
	
	
	#var seeds=SEEDS.instantiate()
	#seeds.position=Vector2(500,500)
	#seeds.z_index=3
	#seeds.visible=true
	#seeds.seed_type="strawberry"
	#add_child(seeds)

#
#func _on_potato_button_down() -> void:
	#print("BUYING")
	#var seeds=SEEDS.instantiate()
	#seeds.position=Vector2(1225,675)
	#seeds.seed_type="potato"
	#add_child(seeds)
