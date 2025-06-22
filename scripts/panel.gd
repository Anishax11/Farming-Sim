extends Panel

@onready var texture_rect: TextureRect = $TextureRect
var button_held=false	

func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input"))

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Clicked panel")
			button_held=true
			#print(texture_rect)
			Global.panel_clicked=!Global.panel_clicked
		elif ! event.pressed:
			button_held=false
			print("Left button")
	
	if event is InputEventMouseMotion and button_held==true:
		print("Dragging")
		texture_rect.position=get_local_mouse_position()
		print(texture_rect.global_position)
