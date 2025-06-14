extends Node2D

const SOIL = preload("res://scenes/soil.tscn")
var x
var y
func _ready() -> void:
	
	for y in range(512,768,+15):
		for x in range(384, -320, -15):
		
			var soil=SOIL.instantiate()
			soil.position=Vector2(x,y)
			add_child(soil)
	
