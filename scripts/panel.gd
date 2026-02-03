extends Panel


class_name panel

var button_held=false	
var panel_number
@onready var grandparent=get_parent().get_parent()
#@onready var texture_rect=get_node("texture")
static var seeds_equipped=false
static var water_equipped=false
var equipped=false # used to check if current panel has equipped item
var inventory
var item_name
var stylebox
var siblings 
var clicked=false
var seeds_name
var seed_count = 6
var seed_type
var transferred=false
var last_five
var score

func _ready():
	var text = self.name
	var regex = RegEx.new()
	regex.compile(r"\d+")  # Matches one or more digits
	var result = regex.search(text)
	panel_number=int(result.get_string(0))
	#print("Panel Loaded")
	mouse_default_cursor_shape=Control.CursorShape.CURSOR_POINTING_HAND
	siblings = get_parent().get_children()
	anchor_left = 1
	anchor_top = 1
	anchor_right = 1
	anchor_bottom = 1
	
	seed_count = PlantTracker.panel_info[self.name]["seed_count"]
	score = PlantTracker.panel_info[self.name]["score"]
		#print(self.name ," limit :",seed_count)
	stylebox = StyleBoxTexture.new()
	
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node
	self.connect("child_entered_tree", Callable(self, "_on_panel_1_child_entered_tree"))
	self.connect("child_exiting_tree", Callable(self, "_on_panel_child_exiting_tree"))
#	self.child_exiting_tree.connect(_on_child_removed)

	inventory=get_parent().get_parent().get_parent()
	while(inventory.inv_initialised==false):
		await get_tree().process_frame
	if Global.equipped_panel == self.name and item_name!=null :
		#print("HIGHLIGHT PANEL")
		highlight_panel()

		
func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print(" Panel detected click: ",self.name," item : ",item_name)
			button_held=true
			#Global.equipped_panel = self.name done in move item func
			#print("Equipped panel : ",self.name)
			#if item_name!=null:
				
				#if clicked==true:
					#
					#for sibling in siblings:
						#if sibling!=self and sibling.stylebox.texture==Global.HIGHLIGHTED_PANEL :
							##print("sibling :",sibling.name)
							#sibling.clicked=false
							#sibling.stylebox.texture=Global.INVENTORY_SLOT
							#add_theme_stylebox_override("panel", sibling.stylebox)
							#sibling.stylebox.expand_margin_left = 0
							#sibling.stylebox.expand_margin_right = 0
							#sibling.stylebox.expand_margin_top = 0
							#sibling.stylebox.expand_margin_bottom = 0
							#last_five = sibling.item_name.substr(sibling.item_name.length() - 5, 5)
							#if  last_five== "seeds":
								#seeds_equipped=false
							#
							#elif sibling.item_name == "watercan":
								#water_equipped = false
					#print("Highlight panel")
					#highlight_panel()
						#
				#else:
					#print("Remove highlight from panel")
					#stylebox.texture=Global.INVENTORY_SLOT
					#add_theme_stylebox_override("panel", stylebox)
					#stylebox.expand_margin_left = 0
					#stylebox.expand_margin_right = 0
					#stylebox.expand_margin_top = 0
					#stylebox.expand_margin_bottom = 0
				##print("clicked:",clicked)	
			##print(Global.inventory_items)
			##print("Clicked panel")
			#button_held=true
			#if item_name!=null:
				#last_five = item_name.substr(item_name.length() - 5, 5)
			#if last_five=="seeds" and get_child(0)!=null :
				##print("Item is seeds")
				##print(get_child(0).name)
				##print(get_child(0).visible)
				##
				#if water_equipped==true:
					#water_equipped=false
					#
				#seeds_equipped=!seeds_equipped
				#
				##print("seeds_equipped",seeds_equipped)
				#
				#Global.equip_item(seed_type)
			##else:
				##print("Item is not seeds")	
				#
			#if item_name=="watercan":
				#if seeds_equipped==true:
					#seeds_equipped=false
				##print("Item is water")
				#water_equipped=!water_equipped
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
			print("Button left :",self.name)
			button_held=false
			
			
			var child=get_child(0)
			if child is TextureRect and item_name!=null:
				#print("TEXTURE:",child.name)
				print("Move item called :",self.name)
				print("PAnel no., item name : ",panel_number," ",item_name)
				Global.move_item(panel_number,item_name)#Passes panel no. to move_item func
				if clicked==true:
					
					for sibling in siblings:
						if sibling!=self and sibling.stylebox.texture==Global.HIGHLIGHTED_PANEL :
							print("sibling :",sibling.name)
							sibling.clicked=false
							sibling.stylebox.texture=Global.INVENTORY_SLOT
							add_theme_stylebox_override("panel", sibling.stylebox)
							sibling.stylebox.expand_margin_left = 0
							sibling.stylebox.expand_margin_right = 0
							sibling.stylebox.expand_margin_top = 0
							sibling.stylebox.expand_margin_bottom = 0
							sibling.clicked=false
							last_five = sibling.item_name.substr(sibling.item_name.length() - 5, 5)
							if  last_five== "seeds":
								seeds_equipped=false
							
							elif sibling.item_name == "watercan":
								water_equipped = false
					print("Highlight panel")
					last_five = item_name.substr(item_name.length() - 5, 5)
					if last_five =="seeds":
						seeds_equipped=true
					highlight_panel()
						
				else:
					print("Remove highlight from panel")
					stylebox.texture=Global.INVENTORY_SLOT
					add_theme_stylebox_override("panel", stylebox)
					stylebox.expand_margin_left = 0
					stylebox.expand_margin_right = 0
					stylebox.expand_margin_top = 0
					stylebox.expand_margin_bottom = 0
					
				#print("clicked:",clicked)	
			#print(Global.inventory_items)
			#print("Clicked panel")
			
			#else:
				#if  child != TextureRect :
					#print("TEXT not found")
				#if item_name==null:
					#print("Item name null")
				#for p in self.get_children():
						#print(child.name)
					
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT :   
		if event.pressed:	
			inventory.get_node("DeleteItemConfirmation").visible=true
			inventory.get_node("DeleteItemConfirmation").panel=self
			
			
			
	if event is InputEventMouseMotion and button_held==true:
		
		#print(get_child(0).position)
		
		#print("DIst from inv:",relative_pos)#-get_parent().get_parent().position.x)
		var child=get_child(0)
		if child is TextureRect:
			#var relative_pos = child.global_position - get_parent().global_position
			#if relative_pos.x<0 or relative_pos.x>190 or relative_pos.y<0 or relative_pos.y>190 :
				#print("item out of inv")
				#print("Parent pos : ",get_parent().global_position)
				#print("Child pos : ",child.global_position )
				#print("Relative POs:",relative_pos)
				#Global.item_out_of_inv=true
				
			Global.panel_clicked=!Global.panel_clicked #Panel clicked shouldnt become true while dragging item
			child.position=event.position 
			
			#if get_node("texture")!=null:
				#get_node("texture").position.x=round(get_node("texture").position.x/40)*40
				#get_node("texture").position.y=round(get_node("texture").position.y/40)*40
				#print("LOC:",get_node("texture").position)
		


func _on_panel_1_child_entered_tree(node: Node) -> void:
	item_name=node.name
	print("Child added to panel :",self.name)
	#print(get_path())
	#print("Seed type :",seed_type)
	var last_five = item_name.substr(item_name.length() - 5, 5)
	var trade_panel = 	get_node("/root/frontyard_scene/TradeBox/TradeInventory/NinePatchRect/GridContainer/"+self.name)
	if trade_panel==null:
		print("Trade panel not found")
	if trade_panel!=null:
		print("Trade panel not nulll")
		var texture_rect=TextureRect.new()
		texture_rect.texture=node.texture
				
		texture_rect.name=node.name
		trade_panel.add_child(texture_rect)
	if node is TextureRect and last_five == "seeds":
		
		
		node.scale=Vector2(0.9,0.9)
		node.position.x+=1
		
		seed_type = item_name.substr(0,item_name.length() - 6)
	
	if node is TextureRect and node.name=="watercan":
		node.position.y+=2
		node.position.x+=1
		node.scale.x=1
		node.scale.y=1.5
		#item_name="watercan"
		
	
		
		#item_name=node.name
		#print("STr texturerect added to panel")
	
	print("Added ",item_name," to panel :",self.name)


func _on_panel_child_exiting_tree(node : Node) :
	#print("Child removeddd")
	stylebox.texture=Global.INVENTORY_SLOT
	add_theme_stylebox_override("panel", stylebox)
	stylebox.expand_margin_left = 0
	stylebox.expand_margin_right = 0
	stylebox.expand_margin_top = 0
	stylebox.expand_margin_bottom = 0
	#var trade_panel = 	get_node("/root/frontyard_scene/TradeBox/TradeInventory/NinePatchRect/GridContainer/"+self.name)
	var trade_panel = get_tree().current_scene.get_node("TradeBox/TradeInventory/NinePatchRect/GridContainer/"+self.name)
	
	
	if trade_panel!=null:
		trade_panel.remove_item(node.name)
		trade_panel.item_name=null
	else:
		print("Trade panel null")

func remove_item():
	#print("Inside")
	print("Removing itemfrom inv and panel",self.name)	
	#Global.inventory_items[][]=item_name
	if item_name!=null:
			#	print("REMOVVE ITEM")	
				self.remove_child(get_node(NodePath(item_name)))
				#print(inventory_node.get_path())
				#Global.inventory_items[int((panel_number-1)/5)][int(panel_number-1)%5]
				var row = int( (panel_number-1)/5 )
				var column = int(panel_number-1)%5
				inventory.remove_item(row,column)
				item_name=null
				clicked=false
				

func highlight_panel():
	stylebox.texture=Global.HIGHLIGHTED_PANEL
	add_theme_stylebox_override("panel", stylebox)   # resets image position
					#get_child(0).position=Vector2(-4,-4)
	stylebox.expand_margin_left = 1.5
	stylebox.expand_margin_right = 1.5
	stylebox.expand_margin_top = 1.5
	stylebox.expand_margin_bottom = 1.5
