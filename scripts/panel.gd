extends Panel

class_name panel

var button_held=false	
var panel_number
@onready var grandparent=get_parent().get_parent()
@onready var texture_rect=get_node("texture")
static var seeds_equipped=false
static var water_equipped=false
var inventory_node
var item_name
var stylebox
var siblings 
var clicked=false
var seeds_name
var seed_type
var transferred=false

func _ready():
	siblings = get_parent().get_children()
	anchor_left = 1
	anchor_top = 1
	anchor_right = 1
	anchor_bottom = 1

	stylebox = StyleBoxTexture.new()
	
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node
	self.connect("child_entered_tree", Callable(self, "_on_panel_1_child_entered_tree"))
	var inventory
	if get_tree().current_scene==get_node("/root/Game"):
		inventory_node=get_node("/root/Game/farm_scene/Farmer/Inventory")
	else:
		inventory_node=get_node("/root/house_interior/Farmer/Inventory")
		
func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			if item_name!=null:
				clicked=!clicked
				if clicked==true:
					
					for sibling in siblings:
						if sibling!=self:
							#print(sibling.name)
							sibling.clicked=false
							sibling.stylebox.texture=Global.INVENTORY_SLOT
							add_theme_stylebox_override("panel", sibling.stylebox)
							sibling.stylebox.expand_margin_left = 0
							sibling.stylebox.expand_margin_right = 0
							sibling.stylebox.expand_margin_top = 0
							sibling.stylebox.expand_margin_bottom = 0
					
					stylebox.texture=Global.HIGHLIGHTED_PANEL
					add_theme_stylebox_override("panel", stylebox)   # resets image position
					#get_child(0).position=Vector2(-4,-4)
					stylebox.expand_margin_left = 1.5
					stylebox.expand_margin_right = 1.5
					stylebox.expand_margin_top = 1.5
					stylebox.expand_margin_bottom = 1.5
						
				else:
					stylebox.texture=Global.INVENTORY_SLOT
					add_theme_stylebox_override("panel", stylebox)
					stylebox.expand_margin_left = 0
					stylebox.expand_margin_right = 0
					stylebox.expand_margin_top = 0
					stylebox.expand_margin_bottom = 0
				print("clicked:",clicked)	
			var inv=get_node("/root/Game/farm_scene/Farmer/Inventory")
			print(Global.inventory_items)
			#print("Clicked panel")
			button_held=true
			#print("ini pos:",texture_rect.position)
			#print("self:",self.position)
			#print(texture_rect.get_path())$TextureRect
			#if get_child(0)!=null:
				#print("Not null")
				#get_child(0).global_position=Vector2(global_position.x+2,global_position.y+2)
			#print(get_child(0).position)
			if item_name=="strawberry_seeds" or item_name=="potato_seeds":
				print("Item is seeds")
				print(get_child(0).name)
				print(get_child(0).visible)
				
				if water_equipped==true:
					water_equipped=false
				seeds_equipped=!seeds_equipped
				#print("seeds_equipped",seeds_equipped)
				
				Global.equip_item(seed_type)
			#else:
				#print("Item is not seeds")	
				
			if item_name=="watercan":
				if seeds_equipped==true:
					seeds_equipped=false
				#print("Item is water")
				water_equipped=!water_equipped
				#Global.equip_item("watercan")
				#print("water_equipped",water_equipped)
			
			#else:
				#print("Item is not water")		
				
		elif ! event.pressed:
			
			
			#if get_child(0)!=null:
				#print("Not null left")
				#get_child(0).global_position=Vector2(global_position.x+2,global_position.y+2)
			#
			#print(get_child(0).position)
			#print("Button left")
			button_held=false
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			
			var child=get_child(0)
			if child is TextureRect:
				#print("TEXTURE:",child.name)
				Global.move_item(panel_number,item_name)#Passes panel no. to move_item func
				
			#else:
				#print("TEXT not found")
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT :   
		if event.pressed:	
			print("Removing itemfrom inv and panel",self.name)	
			if item_name!=null:
			#	print("REMOVVE ITEM")	
				self.remove_child(get_node(item_name))
				#print(inventory_node.get_path())
				inventory_node.remove_item(item_name)
				
	if event is InputEventMouseMotion and button_held==true:
		
		#print(get_child(0).position)
		
		#print("DIst from inv:",relative_pos)#-get_parent().get_parent().position.x)
		var child=get_child(0)
		if child is TextureRect:
			var relative_pos = child.global_position - grandparent.global_position
			if relative_pos.x<0 or relative_pos.x>190 or relative_pos.y<0 or relative_pos.y>190 :
				#print("item out of inv")
				#print("POs:",relative_pos)
				Global.item_out_of_inv=true
				
			Global.panel_clicked=!Global.panel_clicked #Panel clicked shouldnt become true while dragging item
			child.position=event.position 
			
			#if get_node("texture")!=null:
				#get_node("texture").position.x=round(get_node("texture").position.x/40)*40
				#get_node("texture").position.y=round(get_node("texture").position.y/40)*40
				#print("LOC:",get_node("texture").position)
		


func _on_panel_1_child_entered_tree(node: Node) -> void:

	#node.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	#node.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	print("Item added to panel:",node.name)
	#node.global_position=Vector2(global_position.x+2,global_position.y+2)
	
	if node is TextureRect and node.name=="strawberry_seeds" or node.name=="potato_seeds":
		
		print("Added to panel",self.name)
		item_name=node.name
		#node.position=Vector2(0,0)
		#node.scale.x=2
		#node.scale.y=2
		#if seed_type==null:
		#seed_type=get_node("/root/Game/SeedShopInterior/VendorMenu/seeds").seed_type
		if node.name=="strawberry_seeds":
			seed_type="strawberry"
			
		elif node.name=="potato_seeds":
			seed_type="potato"
			
		print("Seeds scale x : ",node.scale.x)
		
		
		
		
		#node.set_anchors_preset(Control.PRESET_CENTER)
		#node.pivot_offset = node.size / 2  # For perfect centering
		
		
		#node.position=Vector2(position.x+2,position.y+2)
		
		#print("SEEDS added:",node)
	if node is TextureRect and node.name=="watercan":
		
		node.scale.x=0.015
		node.scale.y=0.015
		#node.position=Vector2(position.x+2,position.y+2)
		item_name="watercan"
		
	if node is TextureRect and node.name=="strawberry" or node.name=="potato":
		print(node.name," ", node.texture)
		node.position=Vector2(-2,-4)
		
		node.scale.x=0.11
		node.scale.y=0.11
		
		item_name=node.name
		#print("STr texturerect added to panel")
