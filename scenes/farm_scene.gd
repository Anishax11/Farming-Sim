extends Node2D
var FrontyardScene = load("res://scenes/frontyard_scene.gd")
var time_manager
var game = load("res://scenes/game.tscn")
func _on_exit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			print("LEAVE  FARM")
			time_manager=get_node("/root/farm_scene/Farmer/TimeManager")
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i)
			await get_tree().change_scene_to_packed(game)
			Global.load_frontyard=true
