extends Button

#func _ready() -> void:
	#print("HERE")
	#

func _on_button_down() -> void:
	get_parent().exit_shop()
	#await get_tree().change_scene_to_packed(MARKET_PLACE)
	#print("EXITTT")
	##get_parent().get_parent().visible=false
	#Global.current_time=time_manager.current_time
	#Global.time_to_change_tint=time_manager.time_to_change_tint
	#Global.tint_index=time_manager.color_rect.i
	
	#get_parent().get_parent().get_parent().get_node("frontyard_scene").visible=true
