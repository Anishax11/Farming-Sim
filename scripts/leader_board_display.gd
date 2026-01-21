extends Control
var entries : Array
var top_5

func _ready():
	#print("LeaderBoard disp loaded")
	if Global.day_count==7:
		for name in Tutorials.PointTracker:
			entries.append({
			"name": name,
			"points": Tutorials.PointTracker[name]})
		create_leaderboard()
		return
	
		
	entries.sort_custom(func(a, b): #Sort by points (descending)
		return a.points > b.points)
		
	top_5 = entries.slice(0, min(5, entries.size()))
	#print(top_5)
	#top_5 = get_parent().top_5
	#while top_5 == null:
		#await process
	for i in top_5.size():
		#print("top_5[i].name :",top_5[i].name)
		get_tree().current_scene.find_child(str(i+1),true,false).text = top_5[i].name + "  " +str(top_5[i].points)
		#print(get_tree().current_scene.find_child(str(i+1),true,false).get_path())


func create_leaderboard():
	print()
	var on_leaderboard =[]
	var top_player = {
			"name": "Player",
			"points": Tutorials.PointTracker["Player"]} 
	for entry in entries:
		if entry["name"] == "Player":
			entries.erase(entry)
	var start 
	if  Tutorials.PointTracker["Player"]>=5000:
		entries[0] = top_player
		start = 1
		
	elif  Tutorials.PointTracker["Player"]>=4000:
		
		entries[1] =top_player
		start = 2
		
	elif  Tutorials.PointTracker["Player"]>=3000:
		entries[2] = top_player
		start = 3
	elif  Tutorials.PointTracker["Player"]>=2000:
	
		entries[3] = top_player
		start = 4
	elif  Tutorials.PointTracker["Player"]>=1000:
		
		entries[4] =top_player
		start = 5
	
	else:
		top_5 = entries.slice(0, min(5, entries.size()))
		for i in top_5.size():
			get_tree().current_scene.find_child(str(i+1),true,false).text = top_5[i].name + "  " +str(top_5[i].points)
		return
	
	print("START : ",start)
	for i in range(start-1,-1,-1):

		if !entries[i]["name"]=="Player":
			print("player :",entries[i])
			entries[i]["points"] = top_player["points"] + randi_range(1,100)
			top_player = entries[i]
	
	print("DOne setting top")
	top_player = {
			"name": "You",
			"points": Tutorials.PointTracker["Player"]} 
	
	for i in range(start,5):
		
		if !entries[i]["name"]=="Player":# and !char_on_leaderboard:
			print("player :",entries[i])
			entries[i]["points"] = top_player["points"] - randi_range(1,100)
			top_player = entries[i]
	print("DOne setting bottom")	
	top_5 = entries.slice(0, min(5, entries.size()))
	
	for i in top_5.size():
		#print("top_5[i].name :",top_5[i].name)
		get_tree().current_scene.find_child(str(i+1),true,false).text = top_5[i].name + "  " +str(top_5[i].points)
