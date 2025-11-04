extends Node

var plant_stages = {}
var harvested_plants=[]
var plant_names={}

func add_to_plant_dictionary(plant_name):
	print("add_to_plant_dictionary called")
	

	plant_stages[plant_name] = 1
	#print("plant_stages:",plant_stages)


func update_plant_dictionary(plant_name):
	

	plant_stages[plant_name] +=1
	#print(plant_stages)

func add_plant_names(soil_name,plant_name):
	
	plant_names[soil_name]=plant_name
