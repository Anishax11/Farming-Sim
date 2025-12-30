extends Node2D
var time_manager
const FRONTYARD_SCENE = preload("res://scenes/frontyard_scene.tscn")

func _ready() -> void:
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	
	Global.music_fade_in()

func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==1 and body.name == "Farmer":
		print("PLayer here")
		Global.current_time=time_manager.current_time
		Global.time_to_change_tint=time_manager.time_to_change_tint
		Global.tint_index=time_manager.color_rect.i
		Global.player_pos = Vector2(100,750)
		Global.player_direction.y = 1
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)
