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
	print("Plant type:",string_part)
	#print("Plant parent:",get_parent())
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player and animated_sprite_2d.animation!="stage_1" :
		#print("FARMER Y pos",body.position.y)
		#print("PLANT:",position.y)
		z_index=-1


func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		
		z_index=0

func grow_plant():
	print("GROWING ",self.name)
	var last_char = self.name.substr(self.name.length() - 1, 1)
	var index=int(last_char)
	if PlantTracker.plant_stages[self.name]!=null:
		stage=PlantTracker.plant_stages[self.name]+1
	
	print("PLANT STAGE:",stage)
	stage+=1
	print("PLANT STAGE AFTER:",stage)
	#print("Plant grown:",$AnimatedSprite2D.animation)
		
	if stage>3:
		print("Plant in stage greater than 3")
		#print("Harvested plants:",PlantTracker.harvested_plants)
		#print("slf.name:",self.name)
		
		for i in range (PlantTracker.harvested_plants.size()):
			
			if self.name==PlantTracker.harvested_plants[i]:
				#print("Freed")
				queue_free()
				
		stage=3
		animated_sprite_2d.play(string_part+"_stage_"+str(stage))
		return
	
		
	else:
		self.scale.x=0.3
		self.scale.y=0.3
		if stage==3:
			scale.x=0.1
			scale.y=0.1
			print("STage is 3")
			print(string_part+"_stage_"+str(stage))
			animated_sprite_2d.play(string_part+"_stage_"+str(stage))
		else:
			animated_sprite_2d.play("stage_"+str(stage))
		print("PLant animation:",animated_sprite_2d.animation)
		PlantTracker.update_plant_dictionary(self.name)
		
	if 	stage==3:
		
		var sprite_frames = $AnimatedSprite2D.sprite_frames  
		texture = sprite_frames.get_frame_texture(string_part+"_stage_3", 0)	
		
		Global.set(string_part + "_image", texture)
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		
		if event.pressed:
			#print("PlNT harvested")
			
			get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory(string_part,texture)
			get_parent().planted=false
			print("get_parent().planted:",get_parent().planted)
			PlantTracker.harvested_plants.append(self.name)
			PlantTracker.plant_stages.erase(self.name)
			self.remove_child(animated_sprite_2d)
			queue_free()
