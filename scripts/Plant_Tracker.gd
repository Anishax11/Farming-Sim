extends Node

var curr_farm_temp
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
var panel_info={
	"Panel1":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel2":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel3":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel4":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel5":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel6":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel7":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel8":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel9":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel10":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel11":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel12":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel13":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel14":{
	"seed_count" : 0,
	"plant_score" : null
	},
	"Panel15":{
	"seed_count" : 0,
	"plant_score" : null
	}
}  
var prices={
	"strawberry" : 100,
	"potato" : 50,
	"pumpkin" :200,
	"carrot" : 50
	
}

var plant_info = {
	"strawberry" : {
		"difficulty" : 1.3,# moderate
		"ideal_temp" : 21 ,
		"type" : "stable"
	},
	"potato" : {
		"difficulty" : 1,# easy
		"ideal_temp" : 25,
		"type" : "volatile" 
	},
	"pumpkin" :{
		"difficulty" : 1.6,# difficult
		"ideal_temp" : 30 ,
		"type" : "stable"
	},
	"carrot" :{
		"difficulty" : 1,# easy
		"ideal_temp" : 25 
	}
}

var quality_tracker={ # holds quality and past_last_day (key is plant name)
	
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
