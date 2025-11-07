extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
var seed_type
var price
var seed_count = 6
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	print(get_path())
	var label=get_parent().get_node("NinePatchRect2/Label")
	if seed_type=="strawberry":
		label.text="Strawberry Seeds  : 
Bright and sweet, these berries are a farm favorite!
Takes 3 days to grow and yields multiple harvests once mature.
Plant them in spring for the juiciest results — they love the 
sun and a bit of daily care.
 "
	elif seed_type=="potato":
		label.text = "Potato Seeds :
A hearty root crop perfect for any new farmer.
Grows in 3 days, and you might dig up extra potatoes at harvest!
Best planted in cool weather, these dependable crops bring solid
 profits and full bellies."
				
	
	#
		
func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	#_on_input_event(get_viewport(), fake_click, 0)
	#print("fake_input called")



	 	
