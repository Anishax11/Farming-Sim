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
		"completed" : false,
		"acquired" : false
	},
	"Task3"={
		"title" : "Register for the competition",
		"Desc" : "Find the fest centre and complete registration for the festival. ",
		"completed" : false,
		"acquired" : false
	},
	"Task4"={
		"title" : "Proof of worth",
		"Desc" : "Show up on the leaderboard atleast once.",
		"completed" : false,
		"acquired" : false
	},
	"Task5"={
		"title" : "The Two Day Vigil",
		"Desc" : "Grow any plant in the greenhouse and keep it alive after it fully matures for two days.",
		"completed" : false,
		"acquired" : false
	},
	"Task6"={
		"title" : "Measured Faith",
		"Desc" : "Investigate the abandoned church mechanism with the huntress.",
		"completed" : false,
		"acquired" : false
	},
	"Task7" = {
	"title" : "Bound Knowledge",
	"Desc" : "Visit the librarian to get the Book of Plants and learn the ideal conditions needed to properly use the temperature regulator.",
	"completed" : false,
	"acquired" : false
},
"Task8" = {
	"title" : "Buy Seeds",
	"Desc" : "Visit the seed shop in market place and buy seeds .",
	"completed" : false,
	"acquired" : false
},

"Task9" = {
	"title" : "Talk to Maya",
	"Desc" : "Maya seems bothered, help her and ask her about the dials.",
	"completed" : false,
	"acquired" : false
},
"Task10" = {
	"title" : "Talk to Bully",
	"Desc" : ".",
	"completed" : false,
	"acquired" : false
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
