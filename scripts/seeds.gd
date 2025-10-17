extends Area2D
var player
var distance
var empty_panel
var fake_input_called=false
var seed_type
var price
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
				
	
	##print(texture_rect.get_path())
#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT and event.pressed:
		
		#get_node("Seed_Button").visible=true
		#get_node("Seed_Button2").visible=true
		#if seed_type!=null:
			#if seed_type=="strawberry":
				#price=100
			#elif seed_type=="potato":
				#price=50
			#print("SEED TYPE :",seed_type)
			#player=get_node("/root/SeedShopInterior/Farmer")
			##distance=global_position.distance_to(player.position)
			##if fake_input_called==true:
				##distance=0
				##fake_input_called=false
			##print("Player pos:",player.position)
			##print("Seeds pos:",position)
			#
			#if event.pressed :
				#
				#print("BUYING SEEDS....")
				#while texture_rect == null:
					#await get_tree().process_frame
		   		#
				#player.update_coins(-price)
				#get_node("/root/SeedShopInterior/Farmer/Inventory").add_to_inventory(seed_type+"_seeds",Global.strawberry_image)
				#
				#empty_panel=Global.get_empty_panel()
				#texture_rect.name="seeds"
				##$TextureRect.scale.x=0.016
				##$TextureRect.scale.y=0.016
				#
				#
				##empty_panel.add_child(texture_rect)
				##print(empty_panel.get_path())
				##print("running")
				##print($TextureRect.get_path())
				#Input.set_default_cursor_shape(Input.CURSOR_ARROW)
				#queue_free()
				#
		#else:
			#print("SEED TYPE  null")
		
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
