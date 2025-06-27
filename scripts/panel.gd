extends Panel

class_name panel

var button_held=false	
var panel_number
@onready var grandparent=get_parent().get_parent()
@onready var texture_rect=get_node("texture")
static var seeds_equipped=false
static var water_equipped=false

var item_name

func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node
	self.connect("child_entered_tree", Callable(self, "_on_panel_1_child_entered_tree"))
	
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
			
			
			if item_name=="seeds":
				print("Item is seeds")
				if water_equipped==true:
					water_equipped=false
				seeds_equipped=!seeds_equipped
				print("seeds_equipped",seeds_equipped)
			
			else:
				print("Item is not seeds")	
				
			if item_name=="watercan":
				if seeds_equipped==true:
					seeds_equipped=false
				print("Item is water")
				water_equipped=!water_equipped
			
				print("water_equipped",water_equipped)
			
			else:
				print("Item is not water")		
				
		elif ! event.pressed:
			
			#print("Button left")
			button_held=false
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			#print(panel_number)
			if get_node(item_name)!=null:
				
				Global.move_item(panel_number,item_name)#Passes panel no. to move_item func
				
			else:
				print("TEXT not found")
				
	if event is InputEventMouseMotion and button_held==true:
		
		
		
		#print("DIst from inv:",relative_pos)#-get_parent().get_parent().position.x)
		if get_node(item_name)!=null:
			var relative_pos = get_node(item_name).global_position - grandparent.global_position
			if relative_pos.x<0 or relative_pos.x>190 or relative_pos.y<0 or relative_pos.y>190 :
				print("item out of inv")
				#print("POs:",relative_pos)
				Global.item_out_of_inv=true
				
			Global.panel_clicked=!Global.panel_clicked #Panel clicked shouldnt become true while dragging item
			get_node(item_name).position=event.position 
			
			#if get_node("texture")!=null:
				#get_node("texture").position.x=round(get_node("texture").position.x/40)*40
				#get_node("texture").position.y=round(get_node("texture").position.y/40)*40
				#print("LOC:",get_node("texture").position)
		





func _on_panel_1_child_entered_tree(node: Node) -> void:
	
	if node is TextureRect and node.name=="seeds":
		
		item_name="seeds"
	if node is TextureRect and node.name=="watercan":
		
		item_name="watercan"
