extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var stage=0
var texture
var empty_panel
var string_part
func _ready() -> void:
	
	var text=self.name
	var regex=RegEx.new()
	regex.compile(r"\d+")  # Compile pattern to match one or more digits
	string_part=regex.sub(text,"",true)#store string parts by replacing no.s with ""
	print("Plant name:",text)
	print("Plant type:",string_part)
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

#
#


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		
		if event.pressed:
			print("PlNT harvested")
			if stage==3:
				print("Stage is 3")
				Global.planted_soil.erase(get_parent().name)
				Global.sown_soil.erase(get_parent().name)
				Global.tilled_soil.erase(get_parent().name)
				for i in range(Global.planted_soil.size()):
					print(Global.planted_soil[i])
				get_node("/root/farm_scene/Farmer/Inventory").add_to_inventory(string_part,texture)
				get_parent().planted=false
				print("get_parent().planted:",get_parent().planted)
				PlantTracker.harvested_plants.append(self.name)
				PlantTracker.plant_stages.erase(self.name)
				PlantTracker.plant_names.erase(get_parent().name)
				self.remove_child(animated_sprite_2d)
				queue_free()


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
