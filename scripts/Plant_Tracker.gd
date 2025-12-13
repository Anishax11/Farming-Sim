extends Node


var plant_stages = {}
var harvested_plants=[]
var plant_names={}
var plant_stage_limits={
	"strawberry" : 3,
	"potato" : 3,
	"pumpkin" :3,
	"carrot" : 3
}
var locked_growth={}#used to store soil {with plant} which has already been watered once in the day to prevent multiple updates in stage on the same day
# keeps track of panel's seed_count to load back on another day
var panel_seed_count={
	"Panel1":0,
	"Panel2":0,
	"Panel3":0,
	"panel4":0,
	"panel5":0,
	"panel6":0,
	"panel7":0,
	"panel8":0,
	"panel9":0,
	"panel10":0,
	"panel11":0,
	"panel12":0,
	"panel13":0,
	"panel14":0,
	"panel15":0,
}  
var prices={
	"strawberry" : 100,
	"potato" : 50,
	"pumpkin" :80,
	"carrot" : 50
	
}


func add_to_plant_dictionary(plant_name):
	print("add_to_plant_dictionary called")
	

	plant_stages[plant_name] = 1
	#print("plant_stages:",plant_stages)


func update_plant_dictionary(plant_name):
	

	plant_stages[plant_name] +=1
	#print(plant_stages)

func add_plant_names(soil_name,plant_name):
	
	plant_names[soil_name]=plant_name
