extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
var seed_type
var price
var seed_count = 6


func _ready() -> void:
	$AnimatedSprite2D.play(seed_type)
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
				
	elif seed_type=="pumpkin":
		label.text = "Pumpkin Seeds :
A vibrant autumn classic loved by farmers and festivals alike.
Takes 3 days to grow, producing big, cheerful pumpkins!
Resilient and steady, these crops thrive best in mild weather.
Perfect for crafting pies, decorations, or just brightening your fields."
	#
		
func fake_input():
	fake_input_called=true
	var fake_click = InputEventMouseButton.new()
	fake_click.button_index = MOUSE_BUTTON_RIGHT
	fake_click.position =  self.global_position
	
	fake_click.pressed = true
	
	
	#_on_input_event(get_viewport(), fake_click, 0)
	#print("fake_input called")



	 	


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
