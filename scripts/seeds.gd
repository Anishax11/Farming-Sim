extends Area2D
var player
var distance
var empty_panel
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	
	var img= (texture_rect.texture as CompressedTexture2D).get_image()
	Global.seeds_texture=img.save_png_to_buffer()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		player=get_node("/root/Game/farm_scene/Farmer")
		distance=position.distance_to(player.position)
		print(distance)
		if event.pressed and distance<45:
			print("Picked")
			get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory(self.name,$TextureRect.texture)
			empty_panel=Global.get_empty_panel()
			texture_rect.name="seeds"
			
			self.remove_child(texture_rect)
			texture_rect.scale.x=0.016
			texture_rect.scale.y=0.016
			empty_panel.add_child(texture_rect)
			print(empty_panel.get_path())
			print(texture_rect.get_path())
			#queue_free()
