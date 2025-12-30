extends Node
var keys_array: Array = []
var tasks={
	"Task1" ={
		"title" : "Buy Starter Seeds",
		"Desc" : "Purchase strawberry, pumpkin, and potato seeds from the shop.",
		"completed" : false,
		"acquired" : false
	},
	
	"Task2"={
		"title" : "Fresh Strawberries for Aria",
		"Desc" : "Grow and harvest fresh strawberries, then deliver them to Aria so she can install a temperature regulator in your greenhouse.",
		"completed" : true,
		"acquired" : false
	},
	"Task3"={
		"title" : "Register for the competition",
		"Desc" : "Find the fest centre and complete registration for the festival.",
		"completed" : true,
		"acquired" : true
	},
	"Task4"={
		"title" : "Proof of worth",
		"Desc" : "Show up on the leaderboard atleast once.",
		"completed" : false,
		"acquired" : false
	},
	"Task5"={
		"title" : "What the Land Remembers",
		"Desc" : "Grow any crop and keep it within acceptable conditions for 2 full days.",
		"completed" : false,
		"acquired" : true
	}
}
#TASK 1:
var seeds_bought := {
	"strawberry": false,
	"pumpkin": false,
	"potato": false,
	# later...
	# "corn": false,
	# "melon": false,
	# "wheat": false,
}

#TASK 4:
#var showed_up_on_leaderboard = false 

var task_status ={
	"top_5" : [], #TASK 4
	"plant_sustained_counter" : {
		
	} #TASK 5 : keeps track of a plant and its sustained counter in format plant1 : counter
}
