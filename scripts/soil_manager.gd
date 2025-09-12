extends Node2D

const SOIL = preload("res://scenes/soil.tscn")
const TREE = preload("res://scenes/tree.tscn")
const GRASS = preload("res://scenes/grass.tscn")

var x
var y
var id=1
func _ready() -> void:
	print("SOIL MANAGeR")
	
	var inventory=get_node("/root/farm_scene/Farmer/Inventory")
	for y in range(448,768,+15):
		for x in range(-192, 380, +15):
			
			if (y<630 and x>224) or (y<630 and x<-24) or (y>=628):
				
				
				var soil=SOIL.instantiate()
				soil.position=Vector2(x,y)
				soil.name="soil"+str(id)
				
				add_child(soil)
				
				if randi_range(0,90)==1:
				#if id%45==0:
					var grass=GRASS.instantiate()	
					get_node(soil.get_path()).add_child(grass)
					#print(grass.get_path())		
				id+=1
				
	if get_node("soil290")!=null and Global.load_farm==true:
		#print("FARM loaded, day:",Global.day_count)
		#print("Dictionary:",PlantTracker.plant_stages)
		till_soil(Global.tilled_soil,Global.tilled_soil_animation)
		print("Planted soil:",Global.planted_soil)
		
		#for i in range((Global.watered_plants).size()):
		##	print("runnihng loop")
			#if Global.watered_plants[i]!=null:
				##print("watered plnts not nuill")
				#var soil=get_node("/root/Game/farm_scene/SoilManager/"+Global.watered_plants[i])
				#soil.watered=true
	#
	
		for i in range (0,Global.planted_soil.size()):#Used to load back already grown plant(Stage 1) into scene,after this plant is grown to higher stages if watered 
			#var soil=get_node("/root/Game/farm_scene/SoilManager/"+Global.planted_soil[i])
			
			print("GRO@W AT:",Global.planted_soil[i])
			Global.grow_plant(Global.planted_soil[i])
			
			
						
		for i in range (3):
			
			for j in range (5):
				var string=Global.inventory_items[i][j]
				
				if string!="":
					var node=get_node("/root/farm_scene/"+string)		
					if node!=null:
						node.queue_free()			
					Global.inventory_items[i][j]=""
					inventory.add_to_inventory(string,Global.get(string+"_image"))
		
		for i in range((Global.watered_plants).size()):
			#print("runnihng loop watered plants:"+Global.watered_plants[0])
			if Global.watered_plants[i]!=null and Global.day_passed==true:
				#print("watered plnts not nuill")
				var soil=get_node("/root/farm_scene/SoilManager/"+Global.watered_plants[i])
				soil.watered=true
				#print(soil.name+" Watered")
				var plant_found=false
				
				#for child in soil.get_children():
				#
						#if child!=soil.get_node("AnimatedSprite2D") and child!=soil.get_node("CollisionShape2D"):
					#
							#soil.remove_child(child)
						#print("Soil node:",soil.name)
						#print("Child node:", child.name)
				
					
				for j in range(1,PlantTracker.plant_stages.size()+1):
					print("plant_stages:",PlantTracker.plant_stages)
					#print("J:",j)
					#print("Soil :",soil)
					#print("Soil child:",soil.get_child(1))
					if soil.has_node("strawberry"+str(j))!=false  :
						print("PLANT FOUND:","Plant"+str(j))
						soil.get_node("strawberry"+str(j)).grow_plant()	
						plant_found=true
						break
					#else:
						#print("Plant"+str(j)+" not found")
					elif soil.has_node("potato"+str(j))!=false:
						print("PLANT FOUND:","potato"+str(j))
						soil.get_node("potato"+str(j)).grow_plant()	
						plant_found=true
						break
					elif plant_found==false and j==PlantTracker.plant_stages.size():#used to grow plant for the first time
						print("PLANT NOT FOUND: ","Plant"+str(j))
						#print("Growing plant")
						Global.grow_plant(Global.watered_plants[i])
						Global.planted_soil.append(Global.watered_plants[i])#contains plants that have been grown once so they can be reloaded
						
						
			else:
				
				break
				
		for i in range (0,Global.planted_soil.size()):#Used to load back already grown plant(current Stage ) into scene,after this plant is grown to higher stages if watered 
			var soil=get_node("/root/farm_scene/SoilManager/"+Global.planted_soil[i])	
			print("LAST plant :",Global.last_plant_number)
			for j in range(1,Global.last_plant_number + 1):
			
					#print("plant_stages:",PlantTracker.plant_stages)
					#print("J:",j)
					#print("Soil :",soil)
					#print("Soil child:",soil.get_child(1))
					if soil.has_node("strawberry"+str(j))!=false  :
						print("PLANT FOUND:","strawberry"+str(j))
						if PlantTracker.plant_stages.has(soil.get_node("strawberry"+str(j)).name):
							var stage=PlantTracker.plant_stages[soil.get_node("strawberry"+str(j)).name]
							#print(stage)
							soil.watered=true
							if stage!=0:
								print("STge not zero")
								print("stage_"+str(stage))
								
								if stage==3:
									soil.get_node("strawberry"+str(j)).get_node("AnimatedSprite2D").play("strawberry_stage_"+str(stage))
									soil.get_node("strawberry"+str(j)).stage=3
								else:
									soil.get_node("strawberry"+str(j)).get_node("AnimatedSprite2D").play("stage_"+str(stage))
								#print(soil.get_node("strawberry"+str(j)).get_node("AnimatedSprite2D").animation)
								break
					#else:
						#print("Plant"+str(j)+" not found")
					elif soil.has_node("potato"+str(j))!=false:
						print("PLANT FOUND:","potato"+str(j))
						#print(soil.get_node("potato"+str(j)).stage)
						if PlantTracker.plant_stages.has(soil.get_node("potato"+str(j)).name):
							var stage=PlantTracker.plant_stages[soil.get_node("potato"+str(j)).name]
							#print(stage)
							soil.watered=true
							if stage!=0:
								print("STge not zero")
								print("stage_"+str(stage))
								
								if stage==3:
									soil.get_node("potato"+str(j)).get_node("AnimatedSprite2D").play("potato_stage_"+str(stage))
									soil.get_node("potato"+str(j)).stage=3
								else:
									soil.get_node("potato"+str(j)).get_node("AnimatedSprite2D").play("stage_"+str(stage))
								#print(soil.get_node("potato"+str(j)).get_node("AnimatedSprite2D").animation)
								break	
							
			
		Global.load_farm=false	
		if Global.day_passed==true:
			Global.watered_plants.clear()
			Global.day_passed=false			
			
func till_soil(soil,soil_animation):
	
	for i in range(0,Global.tilled_soil.size()):
		if Global.tilled_soil[i]!=null :
			#print(soil[0])
			#print("soil m ",Global.tilled_soil[i])
			get_node(NodePath(soil[i])).tilled=true
			get_node(NodePath(soil[i])).get_node("AnimatedSprite2D").play(soil_animation[i])
			
	for i in range(0,Global.sown_soil.size()):
		if Global.sown_soil!=null:
			get_node(NodePath( Global.sown_soil[i])).planted=true
			get_node(NodePath( Global.sown_soil[i])).get_node("AnimatedSprite2D").play(Global.sown_soil_animation[i])
			
