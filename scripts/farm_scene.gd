extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.gd")
var time_manager
var game = load("res://scenes/game.tscn")
#
func _ready() -> void:
	Global.music_fade_in()
	Dialogic.end_timeline()
	var player = get_node("Farmer")
	if Global.player_pos!=null:
		player.global_position=Global.player_pos
				
	player.animated_sprite_2d.play("backward")
	player.get_node("TimeManager").position+=Vector2(20,20)
	player.get_node("DateLabel").position+=Vector2(20,20)
	player.get_node("CoinLabel").position+=Vector2(2,18)
	if Tutorials.tutorials["farm_tutorial"]==false:
		Dialogic.start("FarmTutorial")	
		Tutorials.tutorials["farm_tutorial"]=true	
			


func _on_exit_body_entered(body: Node2D) -> void:
	print("LEAVE  FARM")
	var time_manager=get_node("/root/farm_scene/Farmer/TimeManager")
	Global.current_time=time_manager.current_time
	Global.time_to_change_tint=time_manager.time_to_change_tint
	Global.tint_index=time_manager.color_rect.i
	Global.player_pos = Vector2(-465,725)
	Global.player_direction.y=-1
	Global.load_frontyard=true
	Global.music_fade_out()
	get_node("Farmer/CanvasLayer2/DimBG").dim_bg(game)
