extends Button


func _ready() -> void:
	print("HERE")
	

func _on_button_down() -> void:
	print("EXITTT")
	#get_parent().get_parent().visible=false
	get_parent().visible=false
	get_parent().get_parent().get_node("farm_scene").visible=true
