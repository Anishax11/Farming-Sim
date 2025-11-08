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
			inventory.panel=self #pass reference
		else:
			print("Item name is null")
		

func _on_panel_1_child_entered_tree(node: Node) -> void:
	item_name=node.name
	print("Item added to trade panel:",node.name)
	
	if node is TextureRect and node.name=="strawberry_seeds" or node.name=="potato_seeds":
		
		print("Added to trade panel :",self.name)
		item_name=node.name
		
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
	print("Item namw :",item_name)


func remove_item(item_name):
	
	if item_name!=null:
			
		self.remove_child(get_node(str(item_name)))
		#print(inventory_node.get_path())
		var row = int( (panel_number-1)/5 )
		var column = int(panel_number-1)%5
		inventory.remove_item(row,column)
		real_inventory.remove_item(row,column)
		item_name=null
		get_tree().get_current_scene().find_child(self.name, true, false).remove_child(get_node(str(item_name)))
