extends Panel

#@onready var texture_rect: TextureRect = $TextureRect
var button_held=false	
var panel_number
func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input")) #Attach signal to node

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Clicked panel")
			button_held=true
			#print("ini pos:",texture_rect.position)
			#print("self:",self.position)
			#print(texture_rect.get_path())
			if $TextureRect!=null:
				print("HAs texture")
				Global.panel_clicked=!Global.panel_clicked
			
		elif ! event.pressed:
			button_held=false
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			print(panel_number)
			if $TextureRect!=null:
				Global.move_item(panel_number)#Passes panel no. to move_item func
			
	if event is InputEventMouseMotion and button_held==true:
		print("Dragging")
		if $TextureRect!=null:
			if $TextureRect.global_position.x<0 or $TextureRect.global_position.x>190 or $TextureRect.global_position.y<600 or $TextureRect.global_position.y>700:
				
				Global.item_out_of_inv=true
				
			Global.panel_clicked=!Global.panel_clicked #Panel clicked shouldnt become true while dragging item
			$TextureRect.position=get_local_mouse_position()
			print($TextureRect.global_position)
