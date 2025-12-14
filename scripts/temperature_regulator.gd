extends CanvasLayer

func _ready() -> void:
	while(get_tree().current_scene.find_child("farm_scene",true,false)==null):
		await get_tree().process_frame
	get_node("Control/TextureRect/TempLabel").text="Temp : " + str(get_node("/root/farm_scene").farm_temp)
	

func _on_increase_button_down() -> void:
	print("INC temp")
	get_node("/root/farm_scene").farm_temp+=1
	get_node("Control/TextureRect/TempLabel").text="Temp : "+str(get_node("/root/farm_scene").farm_temp)


func _on_decrease_button_down() -> void:
	print("Dec temp")
	get_node("/root/farm_scene").farm_temp+=1
	get_node("Control/TextureRect/TempLabel").text="Temp : "+str(get_node("/root/farm_scene").farm_temp)
	
	
