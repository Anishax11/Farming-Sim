extends Area2D
var player
var distance
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	var image=(texture_rect.texture as CompressedTexture2D).get_image()
	Global.watercan_texture=image
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		player=get_node("/root/Game/Farmer")
		distance=position.distance_to(player.position)
		print(distance)
		if event.pressed and distance<45:
			
			get_node("/root/Game/Farmer/Inventory").add_to_inventory(self.name,texture_rect.texture)
			queue_free()
