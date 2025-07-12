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
		print("FARM loaded, day:",Global.day_count)
		#print("Dictionary:",PlantTracker.plant_stages)
		till_soil(Global.tilled_soil,Global.tilled_soil_animation)
		#print("Planted soil:",Global.planted_soil)
	
		for i in range (0,Global.planted_soil.size()):
			#print("GRO@W AT:",Global.planted_soil[i])
			Global.grow_plant(Global.planted_soil[i])
			
		for i in range (3):
			
			for j in range (5):
				var string=Global.inventory_items[i][j]
				
				if string!="":
					var node=get_node("/root/Game/farm_scene/"+string)		
					if node!=null:
						node.queue_free()			
					Global.inventory_items[i][j]=""
					inventory.add_to_inventory(string,Global.get(string+"_image"))
		
		for i in range((Global.watered_plants).size()):
		#	print("runnihng loop")
			if Global.watered_plants[i]!=null:
				#print("watered plnts not nuill")
				var soil=get_node("/root/Game/farm_scene/SoilManager/"+Global.watered_plants[i])
				
				
					
				var plant_found=false
				
				#for child in soil.get_children():
				#
						#if child!=soil.get_node("AnimatedSprite2D") and child!=soil.get_node("CollisionShape2D"):
					#
							#soil.remove_child(child)
						#print("Soil node:",soil.name)
						#print("Child node:", child.name)
				
					
				for j in range(1,PlantTracker.plant_stages.size()+1):
					#print("plant_stages:",PlantTracker.plant_stages)
					#print("J:",j)
					#print("Soil :",soil)
					#print("Soil child:",soil.get_child(1))
					if soil.has_node("Plant"+str(j))!=false:
						#print("PLANT FOUND:","Plant"+str(j))
						soil.get_node("Plant"+str(j)).grow_plant()	
						plant_found=true
						break
					#else:
						#print("Plant"+str(j)+" not found")
					elif plant_found==false:# and j==PlantTracker.plant_stages.size():
						#print("PLANT NOT FOUND: ","Plant"+str(j))
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
			
