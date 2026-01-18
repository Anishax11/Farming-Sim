extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
var price=300
@onready var texture_rect: TextureRect = $TextureRect
var inv
func _ready() -> void:
	inv = get_tree().current_scene.find_child("Inventory",true,false)
	player =  get_tree().current_scene.find_child("Farmer",true,false)

	
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		
		distance=position.distance_to(player.position)
		if fake_input_called==true:
			distance=0
			fake_input_called=false
		print(distance)
		if event.pressed and distance<45:
			while texture_rect == null:
				print("NULL")
				await get_tree().process_frame
			print("CAll add to inv")		
			inv.add_to_inventory(self.name,$TextureRect.texture)
			if inv.full == true:
				print("Inv full!")
				return
			$TextureRect.name="watercan"
			empty_panel=Global.get_empty_panel()
			texture_rect.scale.x=0.016
			texture_rect.scale.y=0.016
			self.remove_child(texture_rect)
			
			
			queue_free()
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	_on_input_event(get_viewport(), fake_click, 0)
#	print("fake_input called")


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
