extends Node2D
var curr_time
var curr_scene
var time_manager
var eiden = load("res://scenes/eiden.tscn")
var maya = load("res://scenes/maya.tscn")
var noa = load("res://scenes/noa.tscn")
var aria = load("res://scenes/aria.tscn")
var aira = load("res://scenes/aira.tscn")
var sera = load("res://scenes/sera.tscn") 
var maya_schedule={
	"6" : "maya_home",
	"9" : "Church",
	"16" : "market_entrance",
	"20" : "maya_home"
}


var aria_schedule={
	"6" : "aria_home",
	"7" : "market_entrance",
	"8" : "SeedShop",
	"10" : "market_exit",
	"11" : "maya_home"
}


var aira_schedule={
	"6" : "maya_home",
	"9" : "library",
	"9.5" : "librarian_desk",
	"17" : "library_entrance",
	"17.5" : "library",
	"19" : "maya_home"
}


var eiden_schedule={
	"6" : "Church",
	"9" : "library",
	"9.2" : "library_entrance",
	"15" : "library_entrance",
	"15.5" : "library",
	"20" : "maya_home"
}

var sera_schedule={
	"6" : "Church",
	"10" : "cafe",
	"16" : "library",
	"20" : "maya_home"
}

var scene_wise_locations ={
	"Game" = {
		"Church" :Vector2(-250,700),
		"Home" : Vector2(-250,700),
		"Greenhouse": Vector2(-250,700),
		"FestCentre" :Vector2(-250,700),
		"maya_home":Vector2(450,700),
		"aria_home": Vector2(-650,750),
		"market_entrance" :Vector2(300,900),
		"library" : Vector2(125,750),
		"cafe" : Vector2(500,750)
		
	},
	"frontyard_scene" = {
		"Church" :Vector2(-250,700),
		"Home" : Vector2(-250,700),
		"Greenhouse": Vector2(-250,700),
		"FestCentre" :Vector2(-250,700),
		"maya_home":Vector2(450,700),
		"aria_home": Vector2(-650,750),
		"market_entrance" :Vector2(300,900),
		"library" : Vector2(125,750),
		"cafe" : Vector2(500,750)
		
	},
	"MarketPlace" = {
		"SeedShop" : Vector2(125,-150),
		"PostOffice" : Vector2(),
		"market_exit" : Vector2(-150,-150)
		},
	
	"LibraryInterior" = {
		"library_entrance" : Vector2(0,100),
		"librarian_desk" : Vector2(0,-115),
	},
	
	"SeedShopInterior" ={
		"cashier_desk" : Vector2(),
		"seed_shop_exit" : Vector2(1000,800),
	}
	
}
var npc_list ={
	"aria" : aria,
	"aira" :aira,
	"eiden" : eiden,
	"sera" : sera
}# [aria,aira,eiden]#,noa,maya]


func _ready():
	print("NPC Manager")
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	curr_time = int(time_manager.current_time)
	curr_scene =  get_tree().current_scene.name
	
	for character in npc_list :
		print("NPC : ",character)
		var spawn_point
		for timeslot in get(character +"_schedule") :
			if curr_time >= int(timeslot):
				spawn_point = get(character +"_schedule")[str(timeslot)]
				print("Spawn point : ",get(character +"_schedule")[str(timeslot)])
				
			
		if scene_wise_locations.has(curr_scene) and scene_wise_locations[curr_scene].has(spawn_point)	:
			print("Spawn at scheduled location :",scene_wise_locations[curr_scene][spawn_point])
			var char = npc_list[character].instantiate()
			char.name = character
			char.global_position = scene_wise_locations[curr_scene][spawn_point]
			add_child(char)
			
func hour_elapsed():

	curr_time = int(time_manager.current_time)
	for children in get_children():
		var char = children.name
		var found = false
		#print("COntrolling :",char.name)
		if (get(char +"_schedule").has(str(curr_time))):
			print("Has time in schedule :",curr_time)
			if scene_wise_locations.has(curr_scene) :
				for location in scene_wise_locations[curr_scene]:
					if (get(char +"_schedule")[str(curr_time)]==location):
						found = true
						if location == "library" or location == "market_exit" or location =="library_entrance" :
							print("scheduled to free later")
							children.free_later = true
						print("Move char to location :",scene_wise_locations[curr_scene][location])
						children.get_node("NavigationAgent2D").target_position = scene_wise_locations[curr_scene][location]
						children.state = children.State.MOVE_TO_TARGET
				#if !found:
					#print("LOvcation not in scene")
					#children.queue_free()
