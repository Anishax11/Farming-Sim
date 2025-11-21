extends Panel
var inventory
var real_inventory
var siblings
var stylebox
var item_name
var panel_number

func _ready() -> void:
	var text = self.name
	var regex = RegEx.new()
	regex.compile(r"\d+")  # Matches one or more digits
	var result = regex.search(text)
	panel_number=int(result.get_string(0))
	#print("Trade panel :",self.name)
	mouse_default_cursor_shape=Control.CursorShape.CURSOR_POINTING_HAND
	siblings = get_parent().get_children()
	anchor_left = 1
	anchor_top = 1
	anchor_right = 1
	anchor_bottom = 1

	stylebox = StyleBoxTexture.new()
	
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node
	self.connect("child_entered_tree", Callable(self, "_on_panel_1_child_entered_tree"))
	self.connect("child_exiting_tree", Callable(self, "_on_panel_child_exiting_tree"))
#	self.child_exiting_tree.connect(_on_child_removed)
	inventory=get_parent().get_parent().get_parent()
	real_inventory = get_tree().current_scene.find_child("Inventory", true, false)
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT  and event.pressed:
		print("Trade :",item_name)
		inventory.get_node("NinePatchRect2").visible=true
		if(item_name!=null):
			inventory.get_node("NinePatchRect2/Label").text="This item costs "+str(Global.ItemPriceList[item_name])+"
			Trade it?"
			inventory.panel=get_tree().get_current_scene().find_child(self.name, true, false)#pass reference
		else:
			inventory.get_node("NinePatchRect2").visible=false
			print("Item name is null")
		

func _on_panel_1_child_entered_tree(node: Node) -> void:
	item_name=node.name
	print("Item added to trade panel:",node.name)
	var last_five = item_name.substr(item_name.length() - 5, 5)
	
	if node is TextureRect and last_five == "seeds":
		
		
		node.scale=Vector2(0.9,0.9)
		node.position.x+=1
	
		
		
	if node is TextureRect and node.name=="watercan":
		
		node.position.y+=2
		node.position.x+=1
		node.scale.x=1
		node.scale.y=1.5
		#node.position=Vector2(position.x+2,position.y+2)
		
		
	
		
		
		#print("STr texturerect added to panel")
	print("Item added to trade panel :",item_name)


func remove_item(item_name):
	print("Remove item called on trade panel")
	if item_name!=null:
		
		print("Removing from trade panel :",item_name)	
		self.remove_child(get_node(str(item_name)))
		item_name=null
		#print(inventory_node.get_path())
		#var row = int( (panel_number-1)/5 )
		#var column = int(panel_number-1)%5
		
		#inventory.remove_item(row,column)
		#real_inventory.remove_item(row,column)
		
		#var real_panel = get_node("/root/Game/frontyard_scene/Farmer/ClickBlocker/Inventory/NinePatchRect/GridContainer/"+self.name)
		#if real_panel==null:
			#real_panel = 	get_node("/root/Game/frontyard_scene/Farmer/ClickBlocker/Inventory/NinePatchRect/GridContainer/"+self.name)
		#if real_panel!=null and real_panel.item_name==item_name:
			#print("Real panel has item")
			#item_name=null
			#real_panel.call("remove_item")
		#if real_panel==null:
			#print("Real panel null")
		#if real_panel.get_node(NodePath(str(item_name)))==null:
			#print("Real panel item null")
		
		#get_tree().get_current_scene().find_child(self.name, true, false).remove_child(get_node(str(item_name)))
