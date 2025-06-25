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
	
	
	#get_node("/root/Game/SoilManager/soil1").add_child(grass)		
	#for i in range(1,10,+1):
	#var tree=TREE.instantiate()
	#tree.position=Vector2(-145,463)
	#add_child(tree)
