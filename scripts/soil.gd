extends Area2D

# after loading farm scene seed type is set to null

class_name Soil
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var tilled=false
var adjusted=false
var planted=false
var distance
var inventory
var planted_seeds
var watered=false
var seed_type
var soil_path="/root/farm_scene/SoilManager/soil"
func _ready() -> void:
	inventory=get_node("/root/farm_scene/Farmer/Inventory")
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
			
			
			var soil_pos=Vector2( int(position.x / 8) * 8,int(position.y / 8) * 8 )
			var player=get_node("/root/farm_scene/Farmer")
			var player_pos=Vector2( int(player.position.x / 8) * 8,int(player.position.y / 8) * 8 )
			distance=soil_pos.distance_to(player_pos)
			#print(distance)
			
			# CODE FOR GROWING PLANT
			if distance<18 and planted==true and panel.water_equipped==true:
				print("TRyna water")
				for soil in Global.watered_plants:
					if watered!=true:
						print("Watered is false")
						#var determine_plant=randi_range(0,1)
						var plant_name
						#if determine_plant==0:
							#plant_name="strawberry"
						#elif determine_plant==1:
							#plant_name="potato"
						#var seed_node=get_node("/root/Game/SeedShopInterior/VendorMenu/seeds")
						#plant_name=seed_node.seed_type
						plant_name=seed_type
						print("watered soil has seeds: ",seed_type)	
						watered=true
						
						if not PlantTracker.plant_stages.has(plant_name+str(Global.plant_number)):
							print("New plant:","Plant"+str(Global.plant_number))
							PlantTracker.add_plant_names(self.name,plant_name+str(Global.plant_number))
							#print("Plant name :",PlantTracker.plant_names[self.name])
							PlantTracker.add_to_plant_dictionary(plant_name+str(Global.plant_number))
							
							Global.plant_number+=1
							
					if soil ==self.name:
						
						print("Plant has been watered",self.name)
						return
					elif soil==Global.watered_plants[Global.watered_plants.size()-1]:
						print("Plant has not been watered",self.name)
						watered=true	
						Global.plant_watered(self)
						if animated_sprite_2d.animation=="seeds":
							animated_sprite_2d.play("watered_seeds")
							#print("Playing watered")
						if animated_sprite_2d.animation=="circle_seeds":
							animated_sprite_2d.play("watered_circle_seeds")
							#print("Playing watered")
						#var determine_plant=randi_range(0,1)
						#var plant_name
						#if determine_plant==0:
							#plant_name="strawberry"
						#elif determine_plant==1:
							#plant_name="potato"
						#print("PLanT Is : ",plant_name)	
						#
						#if not PlantTracker.plant_stages.has(plant_name+str(Global.plant_number)):
							##print("New plant:","Plant"+str(Global.plant_number))
							#PlantTracker.add_plant_names(self.name,plant_name+str(Global.plant_number))
							##print("Plant name :",PlantTracker.plant_names[self.name])
							#PlantTracker.add_to_plant_dictionary(plant_name+str(Global.plant_number))
							#
							#Global.plant_number+=1
							
				if Global.watered_plants.is_empty():
					print("RUNNING 2")
					if watered!=true:
						#var determine_plant=randi_range(0,1)
						var plant_name=seed_type
						#if determine_plant==0:
							#plant_name="strawberry"
						#elif determine_plant==1:
							#plant_name="potato"
						#print("PLanT Is : ",plant_name)	
						print("watered soil has seeds: ",seed_type)	
						if not PlantTracker.plant_stages.has(plant_name+str(Global.plant_number)):
							#print("New plant:","Plant"+str(Global.plant_number))
							PlantTracker.add_plant_names(self.name,plant_name+str(Global.plant_number))
							#print("Plant name :",PlantTracker.plant_names[self.name])
							PlantTracker.add_to_plant_dictionary(plant_name+str(Global.plant_number))
							
							Global.plant_number+=1
						
					
					#print("Watered arr empty")
					#print(self.name," watered :",watered)
					Global.plant_watered(self)
					watered=true	
					if animated_sprite_2d.animation=="seeds":
						animated_sprite_2d.play("watered_seeds")
					elif animated_sprite_2d.animation=="circle_seeds":
						animated_sprite_2d.play("watered_circle_seeds")
						#print("Plying wateed:",animated_sprite_2d.animation)
					#planted=false
					
				#print("Plant watered")
				
		
			
			#CODE FOR PLANTATION
			
			#print("panel.seeds_equipped :",panel.seeds_equipped)
			#print("DIST:",distance)
			#print("SEEDS COUNT:",inventory.seeds_count)
			if distance<18 and tilled==true and panel.seeds_equipped==true :
				var count=Global.equipped_item+"_seeds_count"
				if inventory.get(count)>0:
					print("Plant ",Global.equipped_item)	
					planted=true
					seed_type=Global.equipped_item
					Global.soil_data[self.name]=seed_type
					#planted_seeds=panel.seeds_name
					#print("Seeds count before:",inventory.seeds_count)
					var current = inventory.get(count)
					inventory.set(count, current - 1)
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
				
			if distance<=18 and !tilled:
				#print(self.name)
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
							
					
						elif get_node(soil_path+str(number-1)).adjusted!=true :
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
						elif get_node(soil_path+str(number+1)).adjusted!=true :
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
						if get_node(soil_path+str(number-39)).tilled==true:
							#print("Prev tilled")
							get_node(soil_path+str(number-39)).get_node("AnimatedSprite2D").scale.y=0.21
							
							
						elif get_node(soil_path+str(number-39)).adjusted!=true :
							get_node(soil_path+str(number-39)).get_node("AnimatedSprite2D").play("rect_tilled")
							#print("RECT")
							if get_node(soil_path+str(number-39)).planted==true:
								get_node(soil_path+str(number-39)).get_node("AnimatedSprite2D").play("seeds")
								#print("SEEDS")
							if get_node(soil_path+str(number-39)).watered==true:
								get_node(soil_path+str(number-39)).get_node("AnimatedSprite2D").play("watered_seeds")
								#print("watered_seeds")
							get_node(soil_path+str(number-39)).adjusted=true
							
					if Global.player_direction==Vector2(0,-1):
						
						if get_node(soil_path+str(number+39)).tilled==true:
							#print("Prev tilled")
							get_node(soil_path+str(number+39)).get_node("AnimatedSprite2D").scale.y=0.17
							
							
						elif get_node(soil_path+str(number+39)).adjusted!=true :
							get_node(soil_path+str(number+39)).get_node("AnimatedSprite2D").play("rect_tilled")
							#print("RECT")
							if get_node(soil_path+str(number+39)).planted==true:
								get_node(soil_path+str(number+39)).get_node("AnimatedSprite2D").play("seeds")
								#print("SEEDS")
							if get_node(soil_path+str(number+39)).watered==true:
								get_node(soil_path+str(number+39)).get_node("AnimatedSprite2D").play("watered_seeds")
								#print("watered_seeds")
							get_node(soil_path+str(number+39)).adjusted=true
					tilled=true
					
		else:
			Global.soil_clicked=false
			
		if event is InputEventMouseMotion:
			
			if Global.soil_clicked==true:
				animated_sprite_2d.play("tilled")
				tilled==true
		

			
