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
		Global.load_farm=false
		till_soil(Global.tilled_soil,Global.tilled_soil_animation)
		for i in range (0,Global.planted_soil.size()):
			
			print("GRO@W AT:",Global.planted_soil[i])
			Global.grow_plant(Global.planted_soil[i])
			
		for i in range (3):
			for j in range (5):
				var string=Global.inventory_items[i][j]
				#print("str8ng:",string)
				#
				#if inventory.inv_initialised==true and Global.seeds_initialised and Global.inventory_items[i][j]!="":
					#Global.inventory_items.remove_at([i][j])
					#seeds.call_inv_func()
					#inventory.inv_initialised=false
					#Global.seeds_initialised=false
				if string!="":
					var node=get_node("/root/Game/farm_scene/"+string)
					Global.inventory_items[i][j]=""
					print("SEEDS")
					node.fake_input()
					
func till_soil(soil,soil_animation):
	
	for i in range(0,Global.tilled_soil.size()):
		if Global.tilled_soil[i]!=null :
			#print(soil[0])
			#print("soil m ",Global.tilled_soil[i])
			get_node(NodePath(soil[i])).get_node("AnimatedSprite2D").play(soil_animation[i])
			
	for i in range(0,Global.sown_soil.size()):
		if Global.sown_soil!=null:
			get_node(NodePath( Global.sown_soil[i])).get_node("AnimatedSprite2D").play(Global.sown_soil_animation[i])
			
