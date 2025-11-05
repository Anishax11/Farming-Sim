extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.gd")
var time_manager
var game = load("res://scenes/game.tscn")
#
func _ready() -> void:
	var player = get_node("Farmer")
	if Global.player_pos!=null:
		player.global_position=Global.player_pos
				
	player.direction.y=-1
			
			


func _on_exit_body_entered(body: Node2D) -> void:
	print("LEAVE  FARM")
	var time_manager=get_node("/root/farm_scene/Farmer/TimeManager")
	Global.current_time=time_manager.current_time
	Global.time_to_change_tint=time_manager.time_to_change_tint
	Global.tint_index=time_manager.color_rect.i
	Global.player_pos = Vector2(-465,725)
	Global.player_direction.y=-1
	Global.load_frontyard=true
	get_node("Farmer/CanvasLayer2/DimBG").dim_bg(game)
