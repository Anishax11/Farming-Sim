extends Node2D
var curr_time
var curr_scene
var time_manager
var eiden = load("res://scenes/eiden.tscn")
var maya = load("res://scenes/maya.tscn")
var noa = load("res://scenes/noa.tscn")
var aria = load("res://scenes/aria.tscn")
var aira = load("res://scenes/aira.tscn")

var maya_schedule={
	"6" : "maya_home",
	"9" : "Church",
	"16" : "market_entrance",
	"20" : "maya_home"
}


var aria_schedule={
	"6" : "aria_home",
	"12" : "market_entrance"
}


var aira_schedule={
	"6" : "Church",
	"12" : "aria_home"
}


var eiden_schedule={
	"6" : "maya_home",
	"9" : "Church",
	"16" : "market_entrance",
	"20" : "maya_home"
}



var scene_wise_locations ={
	"Game" = {
		"Church" :Vector2(-250,700),
		"Home" : Vector2(-250,700),
		"Greenhouse": Vector2(-250,700),
		"FestCentre" :Vector2(-250,700),
		"maya_home":Vector2(475,675),
		"aria_home": Vector2(-650,750),
		"market_entrance" :Vector2(300,900)
	},
	"market_scene" = ["SeedShop","PostOffice"]
}
var location_coordinates={
	"Church" : Vector2(-250,700),
	"maya_home" : Vector2(475,675),
	"aria_home" : Vector2(-650,750),
	"market_entrance" : Vector2(300,900)
	
}

var npc_list ={
	"aria" : aria,
	"aira" :aira,
	"eiden" : eiden
}# [aria,aira,eiden]#,noa,maya]


func _ready():
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	curr_time = int(time_manager.current_time)
	curr_scene =  get_tree().current_scene.name
	
	for character in npc_list :
		var spawn_point
		for timeslot in get(character +"_schedule") :
			if curr_time >= int(timeslot):
				spawn_point = get(character +"_schedule")[str(timeslot)]
				break
			else:
				break
		if scene_wise_locations[curr_scene].has(spawn_point)	:
			print("Spawn at scheduled location :",character)
			var char = npc_list[character].instantiate()
			char.name = character
			char.global_position = scene_wise_locations[curr_scene][spawn_point]
			add_child(char)
			
func hour_elapsed():
	curr_time = int(time_manager.current_time)
	for children in get_children():
		var char = children
		print("COntrolling :",char.name)
		if (children.schedule.has(str(curr_time))):
			print("Has time in schedule :",curr_time)
			for location in scene_wise_locations[curr_scene]:
				if (children.schedule[str(curr_time)]==location):
					print("Move char to location :",scene_wise_locations[curr_scene][location])
					children.get_node("NavigationAgent2D").target_position = scene_wise_locations[curr_scene][location]
					children.state = children.State.MOVE_TO_TARGET
	
