extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var stage
var texture
var empty_panel

#func _ready() -> void:

func _on_body_entered(body: Node2D) -> void:
	if body is Player and animated_sprite_2d.animation!="stage_1" :
		#print("FARMER Y pos",body.position.y)
		#print("PLANT:",position.y)
		z_index=-1


func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		
		z_index=0

func grow_plant():
	var last_char = self.name.substr(self.name.length() - 1, 1)
	var index=int(last_char)-1
	stage=PlantTracker.plant_stages["Plant"+str(index)]
	print("GROWING")
	print("PLANT STAGE:",stage)
	stage+=1
	print("PLANT STAGE AFTER:",stage)
	#print("Plant grown:",$AnimatedSprite2D.animation)
		
	
			
			
	if !PlantTracker.harvested_plants.is_empty() and stage>3 and self.name!=PlantTracker.harvested_plants[0]:
		print("Plant in stage greater than 3")
		
		#for i in range (Global.fully_grown_plant_soil.size()):
			#
			#if !PlantTracker.harvested_plants.is_empty() and self.name!=PlantTracker.harvested_plants[i]:
		stage=3
		animated_sprite_2d.play("stage_"+str(stage))
		return
		
	elif !PlantTracker.harvested_plants.is_empty() and stage>3 and self.name==PlantTracker.harvested_plants[0]:
		queue_free()
		
	elif PlantTracker.harvested_plants.is_empty() and stage>3:
		print("Harvested empty")
		stage=3
		animated_sprite_2d.play("stage_"+str(stage))
	
		
	else:
		self.scale.x=0.3
		self.scale.y=0.3
		animated_sprite_2d.play("stage_"+str(stage))
		#print("PLant animation:",animated_sprite_2d.animation)
		PlantTracker.update_plant_dictionary("Plant"+str(index))
		
	if 	stage==3:
		
		var sprite_frames = $AnimatedSprite2D.sprite_frames  
		texture = sprite_frames.get_frame_texture("stage_3", 0)	
		
		Global.strawberry_image=texture
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		
		if event.pressed:
			#print("PlNT harvested")
			
			get_node("/root/Game/farm_scene/Farmer/Inventory").add_to_inventory("strawberry",texture)
			
			PlantTracker.harvested_plants.append(self.name)
			
			self.remove_child(animated_sprite_2d)
			queue_free()
