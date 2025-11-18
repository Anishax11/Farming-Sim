extends Node2D
const SEED_SHOP_INTERIOR = preload("res://scenes/seed_shop_interior.tscn")
const HOUSE_INTERIOR = preload("res://scenes/house_interior.tscn")
const MAIN_MENU = preload("res://scenes/main_menu.tscn")
const MARKET_PLACE = preload("res://scenes/market_place.tscn")
const TASK_MANAGER = preload("res://scenes/task_manager.tscn")
const FARM_SCENE = preload("res://scenes/farm_scene.tscn")

#func _ready() -> void:
	#await get_tree().change_scene_to_packed(HOUSE_INTERIOR)
	#print("FARMMMMMMMMM")
	#var label=Label.new()
	#label.position=Vector2(0,500)
	#label.text="Day : "+str(Global.day_count)
	#
	#get_parent().add_child(label)
	#print("RUNNING")
	#print(label.get_path())
