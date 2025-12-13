extends Area2D


class_name Soil
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var water_audio: AudioStreamPlayer2D = $water_audio

var tilled=false
var adjusted=false
var planted=false
var distance
var inventory
var planted_seeds
var watered=false
var seed_type
var soil_path="/root/farm_scene/SoilManager/soil"
var lock_growth_mechanism=false


func _ready() -> void:
	
	if Global.soil_data.has(self.name):
		
		seed_type=Global.soil_data[self.name]
		print(self.name , " has seed type :", seed_type)
	inventory=get_node("/root/farm_scene/Farmer/ClickBlocker/Inventory")
	if randi_range(0,7)==3:
		animated_sprite_2d.play("untilled_rock")
		#print(get_path())
	#if Global.soil_data.has(self.name):
		#print("Reloaded seed type")
		#seed_type=Global.soil_data[self.name]
		#
	#for i in range(Global.watered_plants.size()):
		#if Global.watered_plants[i]==self.name:
			#watered=true
#func _on_area_entered(area: Area2D) -> void:
	#
	#if !area is Soil: 
		#print(area.name)
		#queue_free()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed and get_node("Grass")==null:
			#print("CLICKEDDDD")
			
			var soil_pos=Vector2( int(position.x / 8) * 8,int(position.y / 8) * 8 )
			var player=get_node("/root/farm_scene/Farmer")
			var player_pos=Vector2( int(player.position.x / 8) * 8,int(player.position.y / 8) * 8 )
			distance=soil_pos.distance_to(player_pos)
			print("dsit : ",distance)
			print("Tilled :",tilled)
			print("water can equipped :",panel.water_equipped)
			if distance<40 and tilled==true and panel.water_equipped==true:
				
				print("Current animation :",animated_sprite_2d.animation)
				
				if(animated_sprite_2d.animation=="seeds"):
						print("rect seeds")
						animated_sprite_2d.play("watered_seeds")
				elif(animated_sprite_2d.animation=="circle_seeds"):
						print("Circ seeds")
						animated_sprite_2d.play("watered_circle_seeds")
				elif(animated_sprite_2d.animation=="tilled"):
						print("Circ tilled")
						animated_sprite_2d.play("watered_circle_tilled")
				elif(animated_sprite_2d.animation=="rect_tilled"):
						print("rect_tilled")
						animated_sprite_2d.play("watered_soil")
				elif(animated_sprite_2d.animation=="tilled"):
						print("rect_tilled")
						animated_sprite_2d.play("watered_circle_tilled")
				water_audio.play() 
				
				await get_tree().create_timer(1.0).timeout
				water_audio.stop()
				
			#NEW CODE FOR GROWING PLANT
			#if distance<40 and planted!=true and panel.water_equipped==true: 
				#print("trying to wate,planted not true")
				
			if distance<40 and planted==true and panel.water_equipped==true: #If plant doesn't exist yet
				#print("trying to water")
				watered=true
				Global.watered_plants.append(self.name)
				
				if not PlantTracker.plant_names.has(self.name):
					var plant_name=seed_type
					PlantTracker.add_plant_names(self.name,plant_name+str(Global.plant_number))
					PlantTracker.add_to_plant_dictionary(plant_name+str(Global.plant_number))
					print("Added new plant: :",plant_name+str(Global.plant_number) )
					Global.plant_number+=1
					PlantTracker.locked_growth[self.name]=true #Set lock on soil so plant stage can only be updated once a day
					
						
				elif !PlantTracker.locked_growth.has(self.name)	: # update stage if it does 
					print("Plant exists, updating stage ")
					PlantTracker.update_plant_dictionary(PlantTracker.plant_names[self.name]) 
					PlantTracker.locked_growth[self.name]=true
					
			
			
			if distance<40 and tilled==true and planted!=true and panel.seeds_equipped==true :
				print("Try planting :",Global.equipped_item)
				
				var panel=inventory.find_child(Global.equipped_panel, true, false)
				
				var count= panel.seed_count
				if count>0:
					#print("Plant ",Global.equipped_item)	
					planted=true
					seed_type=Global.equipped_item
					Global.soil_data[self.name]=seed_type
					#planted_seeds=panel.seeds_name
					#print("Seeds count before:",inventory.seeds_count)
					#var current = inventory.get(count)
					panel.seed_count-=1
					PlantTracker.panel_seed_count[panel.name]=panel.seed_count
					PlantTracker.panel_seed_count[panel.name]=panel.seed_count
					if panel.seed_count == 0:
						Global.equipped_item=null
						Global.equipped_panel=null
						panel.seeds_equipped = false
						panel.remove_item()
						
						
					#print("Seeds count:",inventory.seeds_count)
					if Global.player_direction==Vector2(1,0):
						print("Facing right")
						player.get_node("AnimatedSprite2D").play("seeds_right")
					
					elif Global.player_direction==Vector2(-1,0):
							print("Facing left")
							player.get_node("AnimatedSprite2D").play("seeds_left")
						
					elif Global.player_direction==Vector2(0,1):
						
						player.get_node("AnimatedSprite2D").play("seeds_front")
					
					if animated_sprite_2d.animation=="tilled":
						animated_sprite_2d.play("circle_seeds")
						
					elif animated_sprite_2d.animation=="rect_tilled":
						animated_sprite_2d.play("seeds")
					#print(animated_sprite_2d.animation)
					Global.save_tilled_soil(self,animated_sprite_2d.animation)
				
					
			
			#CODE FOR TILLING
				
			if distance<=18 and !tilled and planted==false:
				print(self.name," is tilled")
				tilled=true
				Global.tilled_soil.append(self.name)
				Global.tilled_soil_animation.append(animated_sprite_2d.animation)
				Global.save_tilled_soil(self,animated_sprite_2d.animation)
				if Global.player_direction==Vector2(1,0):
					if planted!=true:
						rotation_degrees=90 #rotates animation of tilled soil towards right 
					player.get_node("AnimatedSprite2D").play("hoe_right")
					
				if Global.player_direction==Vector2(-1,0):
					if planted!=true:
						rotation_degrees=-90
					
					player.get_node("AnimatedSprite2D").play("hoe_left")
					
				if Global.player_direction==Vector2(0,1):
					if planted!=true:
						rotation_degrees=180
					player.get_node("AnimatedSprite2D").play("hoe_front")
			
				Global.soil_clicked=true
				if adjusted!=true:
					animated_sprite_2d.scale.y=0.2
					animated_sprite_2d.play("tilled")
					
					Global.save_tilled_soil(self,animated_sprite_2d.animation)
					
				var text = self.name
				var regex = RegEx.new()
				regex.compile(r"\d+")  # Matches one or more digits
				var result = regex.search(text)

				if result:
					var number = int(result.get_string(0))
					
					if Global.player_direction==Vector2(1,0): 
						if get_node(soil_path+str(number-1)).tilled==true:
							#print("Prev tilled")
							get_node(soil_path+str(number-1)).get_node("AnimatedSprite2D").scale.y=0.21
							
					
							if get_node(soil_path+str(number-1)).adjusted!=true :
								get_node(soil_path+str(number-1)).get_node("AnimatedSprite2D").play("rect_tilled")
								#print("RECT")
								if get_node(soil_path+str(number-1)).planted==true:
									get_node(soil_path+str(number-1)).get_node("AnimatedSprite2D").play("seeds")
									#print("SEEDS")
								if get_node(soil_path+str(number-1)).watered==true:
									get_node(soil_path+str(number-1)).get_node("AnimatedSprite2D").play("watered_seeds")
									#print("watered_seeds")
								get_node(soil_path+str(number-1)).adjusted=true
							
					if Global.player_direction==Vector2(-1,0):
						if get_node(soil_path+str(number+1)).tilled==true  :
							#print("Prev tilled")
							get_node(soil_path+str(number+1)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node(soil_path+str(number+1)).get_node("CollisionShape2D").scale.y=0.21
							if get_node(soil_path+str(number+1)).adjusted!=true :
									get_node(soil_path+str(number+1)).get_node("AnimatedSprite2D").play("rect_tilled")
									#print("RECT")
									if get_node(soil_path+str(number+1)).planted==true:
										get_node(soil_path+str(number+1)).get_node("AnimatedSprite2D").play("seeds")
										#print("SEEDS")
									if get_node(soil_path+str(number+1)).watered==true:
										get_node(soil_path+str(number+1)).get_node("AnimatedSprite2D").play("watered_seeds")
										#print("watered_seeds")
									#print("RECT")
									get_node(soil_path+str(number+1)).adjusted=true
					
								
					if Global.player_direction==Vector2(0,1):
						if get_node(soil_path+str(number-22)).tilled==true:
							#print("Prev tilled")
							get_node(soil_path+str(number-22)).get_node("AnimatedSprite2D").scale.y=0.21
							
							
							if get_node(soil_path+str(number-22)).adjusted!=true :
								get_node(soil_path+str(number-22)).get_node("AnimatedSprite2D").play("rect_tilled")
								#print("RECT")
								if get_node(soil_path+str(number-22)).planted==true:
									get_node(soil_path+str(number-22)).get_node("AnimatedSprite2D").play("seeds")
									#print("SEEDS")
								if get_node(soil_path+str(number-22)).watered==true:
									get_node(soil_path+str(number-22)).get_node("AnimatedSprite2D").play("watered_seeds")
									#print("watered_seeds")
								get_node(soil_path+str(number-22)).adjusted=true
							
					if Global.player_direction==Vector2(0,-1) and get_node(soil_path+str(number+22))!=null:
						
						if get_node(soil_path+str(number+22)).tilled==true:
							#print("Prev tilled")
							get_node(soil_path+str(number+22)).get_node("AnimatedSprite2D").scale.y=0.17
							
							
							if get_node(soil_path+str(number+22)).adjusted!=true :
								get_node(soil_path+str(number+22)).get_node("AnimatedSprite2D").play("rect_tilled")
								#print("RECT")
								if get_node(soil_path+str(number+22)).planted==true:
									get_node(soil_path+str(number+22)).get_node("AnimatedSprite2D").play("seeds")
									#print("SEEDS")
								if get_node(soil_path+str(number+22)).watered==true:
									get_node(soil_path+str(number+22)).get_node("AnimatedSprite2D").play("watered_seeds")
									#print("watered_seeds")
								get_node(soil_path+str(number+22)).adjusted=true
					
					
		else:
			Global.soil_clicked=false
			
		if event is InputEventMouseMotion:
			
			if Global.soil_clicked==true:
				animated_sprite_2d.play("tilled")
				tilled=true
		

			
