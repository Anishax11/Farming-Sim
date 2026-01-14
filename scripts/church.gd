extends Area2D
const CHURCH_INTERIOR = preload("res://scenes/church_interior.tscn")
var time_manager
func _ready() -> void:
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)

func _on_body_entered(body: Node2D) -> void:
	if body.name!="Farmer" :
		return
	if !TaskManager.tasks["Task3"]["acquired"]:
				print("Talk to aria")
				return
	if Global.player_direction.y==-1:
		#Global.player_pos = Vector2(-214, -187)
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(CHURCH_INTERIOR)
