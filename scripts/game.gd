extends Node2D
#const SEED_SHOP_INTERIOR = preload("res://scenes/seed_shop_interior.tscn")
const MAIN_MENU = preload("res://scenes/main_menu.tscn")
##
func _ready() -> void:
	await get_tree().change_scene_to_packed(MAIN_MENU)
	#print("FARMMMMMMMMM")
	#var label=Label.new()
	#label.position=Vector2(0,500)
	#label.text="Day : "+str(Global.day_count)
	#
	#get_parent().add_child(label)
	#print("RUNNING")
	#print(label.get_path())
