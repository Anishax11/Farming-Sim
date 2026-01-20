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
	"10" : "market_entrance",
	"11" : "maya_home"
}


var aira_schedule={
	"7" : "aira_home",
	"9" : "library",
	"9.5" : "librarian_desk",
	"12" : "library_entrance",
	"17.5" : "library",
	"19" : "aira_home"
}


var eiden_schedule={
	"6" : "Church",
	"9" : "library",
	"9.2" : "library_entrance",
	"15" : "library_entrance",
	"15.5" : "library",
	"20" : "aira_home"
}

var sera_schedule={
	"6" : "Church",
	"8" : "cafe",
	"9" : "library"
	
}

var scene_wise_locations ={
	"Game" = {
		"Church" :Vector2(-250,700),
		"Home" : Vector2(-250,700),
		"Greenhouse": Vector2(-250,700),
		"FestCentre" :Vector2(-250,700),
		"aira_home":Vector2(450,700),
		"aria_home": Vector2(-650,750),
		"market_entrance" :Vector2(300,900),
		"library" : Vector2(125,750),
		"cafe" : Vector2(500,750),
		"maya_home" : Vector2(600,850),
		"noa_home" : Vector2(-200,850)
		
	},
	"frontyard_scene" = {
		"Church" :Vector2(-250,700),
		"Home" : Vector2(-250,700),
		"Greenhouse": Vector2(-650,700),
		"FestCentre" :Vector2(-650,700),
		"aira_home":Vector2(450,700),
		"aria_home": Vector2(-650,750),
		"market_entrance" :Vector2(300,900),
		"library" : Vector2(125,750),
		"cafe" : Vector2(500,750),
		"maya_home" : Vector2(600,850),
		"noa_home" : Vector2(-200,850)
		
	},
	"MarketPlace" = {
		"SeedShop" : Vector2(125,-150),
		"PostOffice" : Vector2(),
		"market_exit" : Vector2(-150,-150),
		"market_entrance" : Vector2(-200,-300)
		},
	
	"LibraryInterior" = {
		"library_entrance" : Vector2(25,200),
		"librarian_desk" : Vector2(25,-75),
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
	"sera" : sera,
	"maya" : maya
}# [aria,aira,eiden]#,noa,maya]

var npc_keys = npc_list.keys()
func _ready():
	#print("NPC Manager")
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	curr_time = int(time_manager.current_time)
	curr_scene =  get_tree().current_scene.name
	#if Global.day_count == 1:
		#for char in npc_list:
			#var timeslot_count = 0
			#var last_time_slot =  get(char +"_schedule").keys().size()-1
			#for timeslot in get(char +"_schedule"):
				#timeslot_count+=1
				#if timeslot_count == last_time_slot: #last destination for the day	
					#get(char +"_schedule")[timeslot] = "FestCentre"
					#print("Location set to fest")
	
	
	for character in npc_list :
		#print("NPC : ",character)
		var spawn_point
		for timeslot in get(character +"_schedule") :
			if curr_time >= int(timeslot):
				spawn_point = get(character +"_schedule")[str(timeslot)]
				#print("Spawn point : ",get(character +"_schedule")[str(timeslot)])
				
			
		if scene_wise_locations.has(curr_scene) and scene_wise_locations[curr_scene].has(spawn_point)	:
			#print("Spawn at scheduled location :",scene_wise_locations[curr_scene][spawn_point])
			var char = npc_list[character].instantiate()
			char.name = character
			char.y_sort_enabled = true

			char.global_position = scene_wise_locations[curr_scene][spawn_point]
			add_child(char)
			
func hour_elapsed():
	
	curr_time = int(time_manager.current_time)
	
					
	for children in npc_list:
		if get_node(children)!=null:
			var char = get_node(children)
			#print("COntrolling :",char.name)
			if (get(children +"_schedule").has(str(curr_time))):
				#print("Has time in schedule :",curr_time)
				if scene_wise_locations.has(curr_scene) :
					for location in scene_wise_locations[curr_scene]:
						#print("Char schedule :",get(children +"_schedule")[str(curr_time)])
						#print("Location :",location)
						if (get(children +"_schedule")[str(curr_time)]==location):
							if location == "library" or location == "market_exit" or location =="library_entrance" :
								#print("scheduled to free later")
								char.free_later = true
							#print("Move char to location :",scene_wise_locations[curr_scene][location])
							char.get_node("NavigationAgent2D").target_position = scene_wise_locations[curr_scene][location]
							char.state = char.State.MOVE_TO_TARGET
				
						
		#elif get(children +"_schedule").has(str(curr_time)) and scene_wise_locations[curr_scene].has(get(children +"_schedule")[str(curr_time)] ):#Char enters scene
			#
			#var char = npc_list[children].instantiate()
			#char.name = children
			#char.global_position = scene_wise_locations[curr_scene][get(children +"_schedule")[str(curr_time)]]
			#add_child(char)
		else :
			var spawn_point
			for timeslot in get(children +"_schedule") :
				if curr_time >= int(timeslot):
					spawn_point = get(children +"_schedule")[str(timeslot)]
					#print("Spawn point : ",get(children +"_schedule")[str(timeslot)])
					
				
			if scene_wise_locations.has(curr_scene) and scene_wise_locations[curr_scene].has(spawn_point)	:
				#print("Spawn at scheduled location :",scene_wise_locations[curr_scene][spawn_point])
				var char = npc_list[children].instantiate()
				char.name = children
				char.y_sort_enabled = true
				char.global_position = scene_wise_locations[curr_scene][spawn_point]
				add_child(char)		
	#if Global.day_count == 7 and curr_time >=18:
			#for children in get_children():
				#var char = children.name
				#print("NPC : ",char)
				#for timeslot in get(char +"_schedule"):
					#var text = get(char +"_schedule")[str(timeslot)]
					#var last_five = text.substr(text.length() - 5, 5)
					#print("Destination (last 5) :",last_five)
					#if last_five == "_home":
						#children.free_later = true
						#if get_tree().current_scene.name == "frontyard_scene":
							#children.get_node("NavigationAgent2D").target_position = Vector2(125,750) #Move to fest centre entrance
