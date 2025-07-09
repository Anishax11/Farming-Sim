extends Node

var plant_stages = {}

func add_to_plant_dictionary(plant_name):
	
	

	plant_stages[plant_name] = 0
	print(plant_stages)


func update_plant_dictionary(plant_name):
	

	plant_stages[plant_name] +=1
	print(plant_stages)
