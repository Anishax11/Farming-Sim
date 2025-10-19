extends Node2D

const FRONTYARD_SCENE = preload("res://scenes/frontyard_scene.tscn")
var GAME = load("res://scenes/game.tscn")
func _ready() -> void:
	get_tree().paused=false
	
func _on_start_game_button_down() -> void:
	print("START GAME")
	get_node("CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)

func _on_load_game_button_down() -> void:
	SaveManager.load_game()

func _on_exit_button_down() -> void:
	get_tree().quit()
