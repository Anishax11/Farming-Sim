extends CanvasLayer
var farm
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	print("TEmp regulatorrr")
	farm = get_node("/root/farm_scene")
	#while(get_tree().current_scene.find_child("farm_scene",true,false)==null):
		#await get_tree().process_frame
	#if farm == null:
		#print("Farm is null")
	if PlantTracker.curr_farm_temp ==null:
		farm.farm_temp = randi_range(18,40)
		PlantTracker.curr_farm_temp = farm.farm_temp
		print("Farm temp is set")
	else:
		farm.farm_temp=PlantTracker.curr_farm_temp 
	get_node("Control/TextureRect/TempLabel").text="Temp : " + str(farm.farm_temp) +"°C"
	

func _on_increase_button_down() -> void:
	if !TaskManager.tasks["Task2"]["completed"]:
		Dialogic.VAR.set("regulator_broken",true)
		Dialogic.start("GeneralMessages")
		return
	print("INC temp")
	farm = get_node("/root/farm_scene")
	farm.farm_temp+=1
	PlantTracker.curr_farm_temp = farm.farm_temp
	get_node("Control/TextureRect/TempLabel").text="Temp : "+str(get_node("/root/farm_scene").farm_temp)+"°C"


func _on_decrease_button_down() -> void:
	if !TaskManager.tasks["Task2"]["completed"]:
		Dialogic.VAR.set("regulator_broken",true)
		Dialogic.start("GeneralMessages")
		return
	
	farm.farm_temp-=1
	PlantTracker.curr_farm_temp = farm.farm_temp
	get_node("Control/TextureRect/TempLabel").text="Temp : "+str(get_node("/root/farm_scene").farm_temp)+"°C"
	
	
func _on_timeline_ended():
	Dialogic.VAR.set("regulator_broken",false)
	
