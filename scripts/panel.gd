extends Panel

class_name panel

var button_held=false	
var panel_number
@onready var grandparent=get_parent().get_parent()
@onready var texture_rect=get_node("texture")
static var seeds_equipped=false
static var water_equipped=false
func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node
	#

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			#print("Dist from parent:",)
			var inv=get_node("/root/Game/Farmer/Inventory")
			print(inv.inventory_items)
			#print("Clicked panel")
			button_held=true
			#print("ini pos:",texture_rect.position)
			#print("self:",self.position)
			#print(texture_rect.get_path())$TextureRect
			if get_node("texture")==null:
				print("NULL")
			var image=get_node("texture").texture.get_image().save_png_to_buffer()
			
			if get_node("texture")!=null and image== Global.seeds_texture.save_png_to_buffer():
				print("Seeds equipped")
				water_equipped=!water_equipped
				seeds_equipped=!seeds_equipped
				
			if get_node("texture")!=null and image== Global.watercan_texture.save_png_to_buffer():
				print("water equipped")
				
				water_equipped=!water_equipped
				seeds_equipped=!seeds_equipped
				
		elif ! event.pressed:
			button_held=false
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			print(panel_number)
			if texture_rect!=null:
				Global.move_item(panel_number)#Passes panel no. to move_item func
			
	if event is InputEventMouseMotion and button_held==true:
		var relative_pos = get_node("texture").global_position - grandparent.global_position
		print("DIst from inv:",relative_pos)#-get_parent().get_parent().position.x)
		if get_node("texture")!=null:
			if relative_pos.x<0 or relative_pos.x>190 or relative_pos.y<0 or relative_pos.y>190 :
				print("item out of inv")
				print("POs:",relative_pos)
				Global.item_out_of_inv=true
				
			Global.panel_clicked=!Global.panel_clicked #Panel clicked shouldnt become true while dragging item
			get_node("texture").position=get_local_mouse_position()
