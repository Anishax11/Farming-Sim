extends Panel

@onready var texture_rect: TextureRect = $TextureRect
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
			Global.panel_clicked=!Global.panel_clicked
		elif ! event.pressed:
			button_held=false
			#Get panel no
			var text = self.name
			var regex = RegEx.new()
			regex.compile(r"\d+")  # Matches one or more digits
			var result = regex.search(text)
			panel_number=int(result.get_string(0))
			print(panel_number)
			#print("panels moved x:", round(texture_rect.position.x / 40))
			var final_panel=round(texture_rect.position.y / 40)*5+round(texture_rect.position.x / 40)+panel_number
			print("Finale panel:",final_panel)
			
	if event is InputEventMouseMotion and button_held==true:
		print("Dragging")
		texture_rect.position=get_local_mouse_position()
		print(texture_rect.global_position)
