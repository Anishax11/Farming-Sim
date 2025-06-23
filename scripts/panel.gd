extends Panel

#@onready var texture_rect: TextureRect = $TextureRect
var button_held=false	
var panel_number
func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input"))

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Clicked panel")
			button_held=true
			#print("ini pos:",texture_rect.position)
			#print("self:",self.position)
			#print(texture_rect.get_path())
			Global.panel_clicked=!Global.panel_clicked
		elif ! event.pressed:
			button_held=false
			
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			print(panel_number)
			Global.move_item(panel_number)
			
	if event is InputEventMouseMotion and button_held==true:
		print("Dragging")
		if $TextureRect!=null:
			$TextureRect.position=get_local_mouse_position()
			print($TextureRect.global_position)
