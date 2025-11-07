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
	for y in range(480,950,+15):
		for x in range(-222, 351, +15):
			#if (y<630 and x>224) or (y<630 and x<-24) or (y>=628):
			#if x>=225 and x<=350 :
			
				
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
	#if 	Global.load_farm==false:
		#print("SLOAD FALSE")
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
	
					
		for i in range((Global.watered_plants).size()):
			print("runnihng loop watered plants:"+str(Global.watered_plants[0]))
			if Global.watered_plants[i]!=null and Global.day_passed==true:
				print("watered plnts not nuill")
				var soil=get_node("/root/farm_scene/SoilManager/"+str(Global.watered_plants[i]))
				soil.watered=true
				print(soil.name+" Watered")
				var plant_found=false
				
				if 	PlantTracker.plant_stages==null or PlantTracker.plant_stages.is_empty():
					print("............... not traversed")
				for j in range(1,PlantTracker.plant_stages.size()+1):
					print("plant_stages:",PlantTracker.plant_stages)
					#print("J:",j)
					#print("Soil :",soil)
					#print("Soil child:",soil.get_child(1))
					#
					#for child in soil.get_children():
						#print(child.name)
					
						
					if soil.get_child_count()>3:
						plant_found=true
						print("PLANT FOUND: ","Plant"+str(j))
					elif plant_found==false and j==PlantTracker.plant_stages.size():#used to grow plant for the first time
						print("PLANT NOT FOUND: ","Plant"+str(j))
						print("Growing this plant for the first time")
						Global.grow_plant(Global.watered_plants[i])
						Global.planted_soil.append(Global.watered_plants[i])#contains plants that have been grown once so they can be reloaded
						
						
			else:
				
				break
				
		for i in range (0,Global.planted_soil.size()):#Used to set soil watered to true
			var soil=get_node("/root/farm_scene/SoilManager/"+Global.planted_soil[i])	
			print("LAST plant :",Global.last_plant_number)
			for j in range(1,Global.last_plant_number + 1):
			
					if soil.has_node("strawberry"+str(j))!=false  :
						print("PLANT FOUND:","strawberry"+str(j))
						if PlantTracker.plant_stages.has(soil.get_node("strawberry"+str(j)).name):
							
							soil.watered=true
							
					
					elif soil.has_node("potato"+str(j))!=false:
						print("PLANT FOUND:","potato"+str(j))
						#print(soil.get_node("potato"+str(j)).stage)
						if PlantTracker.plant_stages.has(soil.get_node("potato"+str(j)).name):
							
							soil.watered=true
							
								
							
			
		Global.load_farm=false	
		if Global.day_passed==true:
			Global.watered_plants.clear()
			PlantTracker.locked_growth.clear()
			Global.day_passed=false	
			
func till_soil(soil,soil_animation):
	print("Till func called")
	for i in range(0,Global.tilled_soil.size()):
		if Global.tilled_soil[i]!=null :
			#print(soil[0])
			#print("soil m ",Global.tilled_soil[i])
			get_node(NodePath(soil[i])).tilled=true
			get_node(NodePath(soil[i])).get_node("AnimatedSprite2D").play(soil_animation[i])
			
		if Global.tilled_soil.is_empty() or Global.tilled_soil==null:
			print("Global.tilled_soil ",i, "is null")
		
			
	for i in range(0,Global.sown_soil.size()):
		if Global.sown_soil!=null:
			#print("SOwn soil:",Global.sown_soil)
			#print(Global.sown_soil_animation[i])
			get_node(NodePath( Global.sown_soil[i])).planted=true
			get_node(NodePath( Global.sown_soil[i])).get_node("AnimatedSprite2D").play(Global.sown_soil_animation[i])
			
