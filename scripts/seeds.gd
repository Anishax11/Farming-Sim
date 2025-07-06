extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	
	var img= (texture_rect.texture as CompressedTexture2D).get_image()
	Global.seeds_texture=img.save_png_to_buffer()
	print(texture_rect.get_path())
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		
		player=get_node("/root/Game/farm_scene/Farmer")
		distance=position.distance_to(player.position)
		if fake_input_called==true:
			distance=0
			fake_input_called=false
		print(distance)
		if event.pressed and distance<45:
			
			print("Picked")
			while texture_rect == null:
				await get_tree().process_frame
	   			
			get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory(self.name,texture_rect.texture)
			empty_panel=Global.get_empty_panel()
			$TextureRect.name="seeds"
			#$TextureRect.scale.x=0.016
			#$TextureRect.scale.y=0.016
			self.remove_child(texture_rect)
			
			empty_panel.add_child(texture_rect)
			print(empty_panel.get_path())
			print("running")
			#print($TextureRect.get_path())
			#queue_free()

func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	_on_input_event(get_viewport(), fake_click, 0)
	print("fake_input called")
