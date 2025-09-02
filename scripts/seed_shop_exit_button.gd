extends Button


func _on_button_down() -> void:
	get_parent().get_parent().visible=false
	get_parent().visible=false
