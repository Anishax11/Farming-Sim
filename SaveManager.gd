extends Node

var game = load("res://scenes/game.tscn")
var saved_data = {
	"player_position": Vector2.ZERO,
	"coins": 1000,
	"current_area": "",
	"inventory": Global.inventory_items,
	"plant_stages":null,
	"planted_soil":null,
	"watered_plants":null,
	"last_plant_number":null,
}

var save_path="user://savegame.json"
var player

func _ready():
	print(game)
	
	#print("current scene",get_tree().get_current_scene().name)
	#if player == null:
		#print("player null")
		#call_deferred("_find_player")
##


	
func save_data():
	saved_data["player_position"]=[player.global_position.x, player.global_position.y]
	saved_data["coins"]=Global.coins_count
	saved_data["current_area"]=get_tree().current_scene.scene_file_path
	saved_data["inventory"]= Global.inventory_items
	saved_data["planted_soil"]= Global.planted_soil
	saved_data["watered_plants"]= Global.watered_plants
	saved_data["plant_stages"]= PlantTracker.plant_stages
	saved_data["last_plant_number"]= Global.last_plant_number
	saved_data["tilled_soil"]= Global.tilled_soil
	saved_data["tilled_soil_animation"]= Global.tilled_soil_animation
	saved_data["sown_soil"]=Global.sown_soil
	saved_data["sown_soil_animation"]=Global.sown_soil_animation
	saved_data["current_time"]=Global.current_time
	saved_data["soil_data"]=Global.soil_data
	saved_data["player_direction"]=[Global.player_direction.x, Global.player_direction.y]
	saved_data["color_rect_i"]=Global.color_rect_i
	saved_data["current_time"]=Global.current_time
	
func save_game():
	print("SAVING....")
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
		print("data:",data)
		var scene_path = data["current_area"]  # string path
		var packed_scene = load(scene_path) as PackedScene  # load as PackedScene
		
		Global.coins_count=data["coins"]
		Global.inventory_items=data["inventory"]
		Global.planted_soil=data["planted_soil"]
		Global.watered_plants=data["watered_plants"]
		Global.last_plant_number=data["last_plant_number"]
		PlantTracker.plant_stages=data["plant_stages"]
		Global.tilled_soil=data["tilled_soil"]
		Global.tilled_soil_animation=data["tilled_soil_animation"]
		Global.sown_soil=data["sown_soil"]
		Global.sown_soil_animation=data["sown_soil_animation"]
		Global.current_time=data["current_time"]
		Global.soil_data=data["soil_data"]
		var dir_array = data["player_direction"]
		Global.player_direction= Vector2( dir_array[0],dir_array[1] )
		Global.color_rect_i=data["color_rect_i"]
		Global.current_time=data["current_time"]
		if data["current_area"]=="res://scenes/farm_scene.tscn":
			
			Global.load_farm=true
		
		
		if packed_scene:
			await get_tree().change_scene_to_packed(packed_scene)
			var t = get_tree().create_timer(0.5)  # one-shot by default
			await t.timeout
			var current_scene = await get_tree().current_scene
			#while(current_scene==null):
			#
				#current_scene = get_tree().current_scene
				#
			if current_scene:  # safety check
				print("Current scene is not null!")
				
			else:
				print("Current scene is still null!")
			if player:
			
				print(player)
				var pos_array = data["player_position"]
				player.position = Vector2(pos_array[0], pos_array[1])
				print("POS:",player.global_position)
				player.get_node("CanvasLayer/ColorRect").i=Global.color_rect_i
				player.get_node("CanvasLayer/ColorRect").adjust_tint()
			else:
				print("Player node not found in current scene!")
		else:
			print("Failed to load scene:", scene_path)
		
		
		#player = get_tree().current_scene.find_child("Farmer", true, false)

	
