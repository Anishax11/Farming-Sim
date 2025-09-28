extends Node2D
var game = load("res://scenes/game.tscn")
var player 
func _ready():
	player=get_node("Farmer")
	var inventory=get_node("Farmer/Inventory")
	for i in range (3):
		for j in range (5):
			var string=Global.inventory_items[i][j]
				
			if string!="":
				Global.inventory_items[i][j]=""
				inventory.add_to_inventory(string,null)
				

	


func _on_front_yard_entrance_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==-1:
	
		#print("PLayer dir:",Global.player_direction.y)	
		print("PLayer here")
		await get_tree().change_scene_to_packed(game)
