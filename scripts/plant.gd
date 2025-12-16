extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var quality 
var stage=0
var texture
var empty_panel
var string_part
var farm
var score # score = quality x difficulty
# plant quality will increment on last day but not after that even if its not harvested
func _ready() -> void:
	
	var text=self.name
	var regex=RegEx.new()
	regex.compile(r"\d+")  # Compile pattern to match one or more digits
	string_part=regex.sub(text,"",true)#store string parts by replacing no.s with ""
	#print("Plant name:",text)
	#print("Plant type:",string_part)
	var match = regex.search(text)
	Global.last_plant_number = int(match.get_string())
	stage = PlantTracker.plant_stages[self.name]
	
	if stage>= PlantTracker.plant_stage_limits[string_part]:
		stage=PlantTracker.plant_stage_limits[string_part]
		PlantTracker.plant_stages[self.name]=stage
		
	
	
	print("Plant instantiated, play animation :",string_part+"_stage_"+str(stage))
	if string_part=="potato":
		animated_sprite_2d.scale=Vector2(1,1)
		global_position.y+=2
		
	elif string_part=="strawberry" and stage>1:
		if stage==2:
			animated_sprite_2d.scale=Vector2(0.25,0.25)
		else:
			animated_sprite_2d.scale=Vector2(0.3,0.3)
		global_position.x-=2
		global_position.y+=1
	
	animated_sprite_2d.play(string_part+"_stage_"+str(stage))
	
	if not PlantTracker.quality_tracker.has(self.name):
		quality = 40
		PlantTracker.quality_tracker[self.name]={
			"quality" : 40,
			"past_last_day" : false
		}
	else:
		quality = PlantTracker.quality_tracker[self.name]["quality"]
		
	farm  = get_node("/root/farm_scene")
	if farm == null:
		print("Farm is null")
	if farm.farm_temp == null:
		print("farm_temp is null")
		
	var temp_diff = abs(farm.farm_temp - PlantTracker.plant_info[string_part]["ideal_temp"])
	print("Ideal temp : ",PlantTracker.plant_info[string_part]["ideal_temp"])
	print("farm temp :",farm.farm_temp)
	print("Temp diff :", temp_diff)
	
	if stage==PlantTracker.plant_stage_limits[string_part] and PlantTracker.quality_tracker[self.name]["past_last_day"]==true : # quality won't be increased anymore once plant is in its final stage, but it can fall
		if  PlantTracker.plant_info[string_part]["difficulty"] ==1: # easy difficulty
			if temp_diff >7 :
				quality-=5
		elif PlantTracker.plant_info[string_part]["difficulty"] ==1.3:# moderate difficulty
			if temp_diff >5 :
				quality-=10
			
		else: # high difficulty
			if temp_diff >3 :
				quality-=30
		
		
	else :
		if stage==PlantTracker.plant_stage_limits[string_part]:
			PlantTracker.quality_tracker[self.name]["past_last_day"]=true
		if  PlantTracker.plant_info[string_part]["difficulty"] ==1: # easy difficulty
			if temp_diff <=5 :
				quality+=20
			elif temp_diff <=7 :
				quality+=10
			else:
				quality-=5
		elif PlantTracker.plant_info[string_part]["difficulty"] ==1.3:# moderate difficulty
			if temp_diff <=3 :
				quality+=31
			elif temp_diff <=5 :
				quality+=10
			else:
				quality-=10
		else: # high difficulty
			if temp_diff <=2 :
				quality+=40
			elif temp_diff <=3 :
				quality+=10
			else:
				quality-=30
	
	PlantTracker.quality_tracker[self.name]["quality"] = quality
	#if not PlantTracker.quality_tracker.has(self.name) :
		#PlantTracker.quality_tracker[self.name] = {"quality": quality, "past_last_day":false} 
	#else:
		#PlantTracker.quality_tracker[self.name] = quality 
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton :
		
		if event.pressed and  event.button_index == MOUSE_BUTTON_RIGHT:
			
			if Inventory.full == true:
				print("Inv full!")
				return
			print("PlNT harvested")
			if stage==PlantTracker.plant_stage_limits[string_part]:
				score = quality * PlantTracker.plant_info[string_part]["difficulty"]
				print("Stage is 3")
				Global.planted_soil.erase(get_parent().name)
				Global.sown_soil.erase(get_parent().name)
				Global.tilled_soil.erase(get_parent().name)
				#for i in range(Global.planted_soil.size()):
					#print(Global.planted_soil[i])
				get_node("/root/farm_scene/Farmer/ClickBlocker/Inventory").add_to_inventory(string_part,texture)
				var curr_panel = Global.get_empty_panel() # panel with harvested plant
				curr_panel.plant_score = score
				get_parent().planted=false
				get_parent().tilled=false
				#print("get_parent().planted:",get_parent().planted)
				PlantTracker.harvested_plants.append(self.name)
				PlantTracker.plant_stages.erase(self.name)
				PlantTracker.plant_names.erase(get_parent().name)
				self.remove_child(animated_sprite_2d)
				queue_free()
		
		if event.pressed and  event.button_index == MOUSE_BUTTON_LEFT:
			print("Quality is : ",quality)
			print("Diff is : ",PlantTracker.plant_info[string_part]["difficulty"])

func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
