extends Node
var saved_data = {
	"player_position": Vector2.ZERO,
	"coins": 1000,
	"current_area": "",
	"inventory": Global.inventory_items
}

var save_path="user://savegame.json"
var player

func _ready():
	
	get_tree().connect("current_scene_changed", Callable(self, "_on_scene_changed"))
	player = get_tree().get_current_scene().get_node_or_null("frontyard_scene/Farmer")
	print("current scene",get_tree().get_current_scene().name)
	if player == null:
		print("player null")
		call_deferred("_find_player")

func _on_scene_changed(new_scene):
	print("Scene chnaged")
	print("Scene changed to:", new_scene.name)
	#find player in the new scene
	player = get_tree().current_scene.find_node("Farmer", true, false)

#func _find_player():
	#player =get_node("/root/Game/frontyard_scene/Farmer")
	
func save_data():
	saved_data["player_position"]=[player.global_position.x, player.global_position.y]
	saved_data["coins"]=Global.coins_count
	saved_data["current_area"]=get_tree().current_scene.scene_file_path
	saved_data["inventory"]= Global.inventory_items
	

func save_game():
	save_data()
	var file=FileAccess.open(save_path,FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(saved_data))
		file.close()
		print("Saved Game")
	
func load_game():

	if not FileAccess.file_exists(save_path):
		print("No save file found.")
		return
	var file=FileAccess.open(save_path,FileAccess.READ)
	
	if file:
		var text = file.get_as_text()
		file.close()
		
		print("Save file raw text:", text)
		#var parse_result = JSON.parse_string(text)
		#if parse_result.error != OK:
			#print("Parse error")
			#return
			
		var data = JSON.parse_string(text)
		
		
		
		
		var scene_path = data["current_area"]  # string path
		var packed_scene = load(scene_path) as PackedScene  # load as PackedScene

		if packed_scene:
			await get_tree().change_scene_to_packed(packed_scene)
			
			var current_scene = get_tree().current_scene
			
			if current_scene:  # safety check
				print("Current scene isnot null!")
				
			else:
				print("Current scene is still null!")
		else:
			print("Failed to load scene:", scene_path)
		
		Global.coins_count=data["coins"]
		Global.inventory_items=data["inventory"]
		_on_scene_changed(get_tree().current_scene)
		player = get_tree().current_scene.find_node("Farmer", true, false)
		if player:
			var pos_array = data["player_position"]
			player.global_position = Vector2(pos_array[0], pos_array[1])
			print("POS:",player.global_position)
		else:
			print("Player node not found in current scene!")
	
