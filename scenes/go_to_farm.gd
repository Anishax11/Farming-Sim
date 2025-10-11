extends Area2D
var time_manager
var FARM_SCENE = load("res://scenes/farm_scene.tscn")

#func _ready() -> void:
	#time_manager=get_parent().time_manager
	


			
			


func _on_body_entered(body: Node2D) -> void:
			print("Open farm")
			get_parent().get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FARM_SCENE)
			
			time_manager=get_node("/root/Game/frontyard_scene/Farmer/TimeManager")
			if time_manager==null:
				time_manager=get_node("/root/frontyard_scene/Farmer/TimeManager")
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i)
			
			Global.load_farm=true
