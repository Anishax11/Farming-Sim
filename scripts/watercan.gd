extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:


	var image=(texture_rect.texture as CompressedTexture2D).get_image()
	Global.watercan_texture=image.save_png_to_buffer()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		player=get_node("/root/Game/farm_scene/Farmer")
		distance=position.distance_to(player.position)
		if fake_input_called==true:
			distance=0
			fake_input_called=false
		print(distance)
		if event.pressed and distance<45:
			while texture_rect == null:
				await get_tree().process_frame
					
			get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory(self.name,$TextureRect.texture)
			$TextureRect.name="watercan"
			empty_panel=Global.get_empty_panel()
			texture_rect.scale.x=0.016
			texture_rect.scale.y=0.016
			self.remove_child(texture_rect)
			
			
			queue_free()


func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	_on_input_event(get_viewport(), fake_click, 0)
#	print("fake_input called")
