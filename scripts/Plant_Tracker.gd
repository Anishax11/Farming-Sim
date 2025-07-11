extends Node

var plant_stages = {}
var harvested_plants=[]
func add_to_plant_dictionary(plant_name):
	
	

	plant_stages[plant_name] = 0
	#print(plant_stages)


func update_plant_dictionary(plant_name):
	

	plant_stages[plant_name] +=1
	#print(plant_stages)
