extends StaticBody2D

var time_manager
var FEST_CENTRE = load("res://scenes/fest_centre.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D or body.name != "Farmer":
			return
	
	time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	if time_manager==null:
			time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	Global.player_pos = Vector2(50,500)
		
	get_parent().get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FEST_CENTRE)
			
