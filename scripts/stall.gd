extends Area2D
const SEEDS = preload("res://scenes/seeds.tscn")

func _ready():
	print("STALL z index: ",z_index)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		get_parent().visible=false
		get_parent().get_parent().get_node("SeedShopInterior").visible=true
		#var seeds=SEEDS.instantiate()
		#seeds.scale=Vector2(5,5)
		#add_child(seeds)
