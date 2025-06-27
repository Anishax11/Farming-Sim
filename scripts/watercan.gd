extends Area2D
var player
var distance
var empty_panel
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	var image=(texture_rect.texture as CompressedTexture2D).get_image()
	Global.watercan_texture=image.save_png_to_buffer()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		player=get_node("/root/Game/Farmer")
		distance=position.distance_to(player.position)
		print(distance)
		if event.pressed and distance<45:
			
			get_node("/root/Game/Farmer/Inventory").add_to_inventory(self.name,texture_rect.texture)
			texture_rect.name="watercan"
			empty_panel=Global.get_empty_panel()
			self.remove_child(texture_rect)
			texture_rect.scale.x=0.016
			texture_rect.scale.y=0.016
			empty_panel.add_child(texture_rect)
			queue_free()
