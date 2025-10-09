extends Control
#
#func _ready():
	##process_mode = Node.PAUSE_MODE_PROCESS
	#get_node("PanelContainer/VBoxContainer/RESUME").pressed.connect(_on_resume_button_down)
	
func _on_resume_button_down() -> void:
	
	print("ReSume")
	visible=false
	get_tree().paused=false
	


func _on_go_to_main_menu_button_down() -> void:
	pass # Replace with function body.


func _on_save_button_button_down() -> void:
	SaveManager.save_game()


func _on_load_button_button_down() -> void:
	visible=false
	get_tree().paused=false
	SaveManager.load_game()
