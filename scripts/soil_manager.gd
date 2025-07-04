extends Node2D

const SOIL = preload("res://scenes/soil.tscn")
const TREE = preload("res://scenes/tree.tscn")
const GRASS = preload("res://scenes/grass.tscn")

var x
var y
var id=1
func _ready() -> void:
	
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
		till_soil(Global.tilled_soil,Global.tilled_soil_animation)
		for i in range (0,Global.planted_soil.size()):
			
			print("GRO@W AT:",Global.planted_soil[0])
			Global.grow_plant(Global.planted_soil[0])
	
func till_soil(soil,soil_animation):
	for i in range(0,Global.tilled_soil.size()):
		if Global.tilled_soil[i]!=null :
			#print(soil[0])
			#print("soil m ",Global.tilled_soil[i])
			get_node(NodePath(soil[i])).get_node("AnimatedSprite2D").play(soil_animation[i])
			
	for i in range(0,Global.sown_soil.size()):
		if Global.sown_soil!=null:
			get_node(NodePath( Global.sown_soil[i])).get_node("AnimatedSprite2D").play(Global.sown_soil_animation[i])
		
