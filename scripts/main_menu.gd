extends Node2D

var OPENING_SCENE = load("res://scenes/opening_scene.tscn")

func _ready() -> void:
	Global.music_fade_in()
	get_tree().paused=false
	
func _on_start_game_button_down() -> void:
	Global.music_fade_out()
	print("START GAME")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.VAR.set("enter_name",true)
	Dialogic.start("GeneralMessages")
	
func _on_load_game_button_down() -> void:
	Global.music_fade_out()
	SaveManager.load_game()

func _on_exit_button_down() -> void:
	Global.music_fade_out()
	get_tree().quit()

func _on_timeline_ended():
	Global.music_fade_out()
	get_node("CanvasLayer2/DimBG").dim_bg(OPENING_SCENE)
