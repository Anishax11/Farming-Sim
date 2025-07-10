extends Node2D

const SOIL = preload("res://scenes/soil.tscn")
const TREE = preload("res://scenes/tree.tscn")
const GRASS = preload("res://scenes/grass.tscn")

var x
var y
var id=1
func _ready() -> void:
	
	
	var inventory=get_node("/root/Game/farm_scene/Farmer/Inventory")
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
		#print("FARM loaded")
		#print("Dictionary:",PlantTracker.plant_stages)
		till_soil(Global.tilled_soil,Global.tilled_soil_animation)
		#print("Planted soil:")
		
		#CODE TO LOAD BACK GROWN PLANT UNLEWSS ITS FULLY GROWN(NOT WORKING)
		for i in range (0,Global.planted_soil.size()):
			for j in range(Global.fully_grown_plant_soil.size()):
				if Global.planted_soil[i]==Global.fully_grown_plant_soil[j]:
					print("Plant has grown fully")
					break
				elif j==Global.fully_grown_plant_soil.size()-1:
					print("GRO@W AT:",Global.planted_soil[i])
					Global.grow_plant(Global.planted_soil[i])
			
		for i in range (3):
			
			for j in range (5):
				var string=Global.inventory_items[i][j]
				
				if string!="":
					
					var node=get_node("/root/Game/farm_scene/"+string)
					Global.inventory_items[i][j]=""
					#print("SEEDS")
					node.fake_input()
		
		for i in range((Global.watered_plants).size()):
		#	print("runnihng loop")
			if Global.watered_plants[i]!=null:
				print("watered plnts not nuill")
				var soil=get_node("/root/Game/farm_scene/SoilManager/"+Global.watered_plants[i])
				for child in soil.get_children():
				
					if child!=soil.get_node("AnimatedSprite2D") and child!=soil.get_node("CollisionShape2D") and child.name!="Plant2":
						print("child removed")
						soil.remove_child(child)
					print("Child node:", child.name)
				var plant_found=false
				
				for j in range(0,PlantTracker.plant_stages.size()+2):
					print("plant_stages:",PlantTracker.plant_stages)
				
					if soil.get_node("Plant"+str(j))!=null:
						print("PLANT FOUND")
						soil.get_node("Plant"+str(j)).grow_plant()	
						plant_found=true
						break
					#else:
						#print("Plant"+str(j)+" not found")
					elif plant_found==false:# and j==PlantTracker.plant_stages.size()-1:
						
						print("PLANT NOT FOUND")
						Global.grow_plant(Global.watered_plants[i])
						Global.planted_soil.append(Global.watered_plants[i])		
			else:
				#Global.watered_plants.clear()
				break
		Global.day_passed=false		
		Global.load_farm=false		
			
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
			
