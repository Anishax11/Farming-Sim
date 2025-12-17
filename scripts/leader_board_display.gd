extends Control
var entries : Array
var top_5

func _ready():
	for name in Tutorials.PointTracker:
		entries.append({
		"name": name,
		"points": Tutorials.PointTracker[name]})
		
	entries.sort_custom(func(a, b): #Sort by points (descending)
		return a.points > b.points)
		
	top_5 = entries.slice(0, min(5, entries.size()))
	#top_5 = get_parent().top_5
	#while top_5 == null:
		#await process
	for i in top_5.size():
		get_tree().current_scene.find_child(str(i+1),true,false).text = top_5[i].name + "  " +str(top_5[i].points)
		
