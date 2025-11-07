extends Control
var panel

func _on_discard_button_down() -> void:
	
	if panel.item_name!=null:
			
		if panel==null:
			print("Panel not set")	
		panel.remove_item()
		visible=false		


func _on_cancel_discard_button_down() -> void:
	visible=false
