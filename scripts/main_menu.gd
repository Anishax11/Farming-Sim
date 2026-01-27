extends Node2D

var OPENING_SCENE = load("res://scenes/opening_scene.tscn")

func _ready() -> void:
	get_tree().paused=false
	
func _on_start_game_button_down() -> void:
	print("START GAME")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.VAR.set("enter_name",true)
	Dialogic.start("GeneralMessages")
	
func _on_load_game_button_down() -> void:
	SaveManager.load_game()

func _on_exit_button_down() -> void:
	get_tree().quit()

func _on_timeline_ended():
	get_node("CanvasLayer2/DimBG").dim_bg(OPENING_SCENE)
