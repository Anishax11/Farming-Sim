extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.gd")
var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
var time_manager
var game = load("res://scenes/game.tscn")

func _ready() -> void:
	Global.music_fade_in()
	Dialogic.end_timeline()
	var player = get_node("Farmer")
	var cam=player.get_node("Camera2D")
	cam.zoom.x+=0.6
	cam.limit_left=-230
	cam.limit_right=310
	cam.limit_top=250
	cam.limit_bottom=650
	
	#if Global.player_pos!=null:
		#player.global_position=Global.player_pos
				#
	player.animated_sprite_2d.play("backward")

	
	if Tutorials.tutorials["farm_tutorial"]==false:
		Dialogic.start("FarmTutorial")	
		Tutorials.tutorials["farm_tutorial"]=true	
			


func _on_exit_body_entered(body: Node2D) -> void:
	print("LEAVE  FARM")
	var time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	Global.current_time=time_manager.current_time
	Global.time_to_change_tint=time_manager.time_to_change_tint
	Global.tint_index=time_manager.color_rect.i
	Global.player_pos = Vector2(-663,725)
	Global.player_direction.y=-1
	Global.load_frontyard=true
	Global.music_fade_out()
	get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)
