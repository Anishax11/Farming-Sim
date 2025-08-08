extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
var seed_type
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	print("SEEDS NAME: ",self.name)
	Global.seeds_image=texture_rect.texture
	#print(texture_rect.get_path())
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT and event.pressed:
		
		get_node("Seed_Button").visible=true
		get_node("Seed_Button2").visible=true
		if seed_type!=null:
			print("SEED TYPE not null")
			player=get_node("/root/Game/farm_scene/Farmer")
			distance=global_position.distance_to(player.position)
			if fake_input_called==true:
				distance=0
				fake_input_called=false
			#print("Player pos:",player.position)
			#print("Seeds pos:",position)
			print(distance)
			if event.pressed and distance<45:
				
				print("Picked")
				while texture_rect == null:
					await get_tree().process_frame
		   			
				get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory(self.name,texture_rect.texture)
				
				empty_panel=Global.get_empty_panel()
				texture_rect.name="seeds"
				#$TextureRect.scale.x=0.016
				#$TextureRect.scale.y=0.016
				self.remove_child(texture_rect)
				
				#empty_panel.add_child(texture_rect)
				#print(empty_panel.get_path())
				#print("running")
				#print($TextureRect.get_path())
				texture_rect.queue_free()
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		
		
func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	_on_input_event(get_viewport(), fake_click, 0)
	#print("fake_input called")



func _on_mouse_entered() -> void:
	
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	 
func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
