extends Node2D

const SOIL = preload("res://scenes/soil.tscn")
const TREE = preload("res://scenes/tree.tscn")
var x
var y
var id=1
func _ready() -> void:
	
	for y in range(448,768,+15):
		for x in range(-192, 380, +15):
			
			if (y<600 and x>224) or (y<600 and x<-24) or (y>=600):
				
				
				var soil=SOIL.instantiate()
				soil.position=Vector2(x,y)
				soil.name="soil"+str(id)
				add_child(soil)
				id+=1
				
	#for i in range(1,10,+1):
	#var tree=TREE.instantiate()
	#tree.position=Vector2(-145,463)
	#add_child(tree)
