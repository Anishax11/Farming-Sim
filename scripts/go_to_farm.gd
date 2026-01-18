extends Area2D
var time_manager
var FARM_SCENE = load("res://scenes/farm_scene.tscn")

#func _ready() -> void:
	#time_manager=get_parent().time_manager
	
func _on_body_entered(body: Node2D) -> void:
			if body.name!="Farmer":
				return
			#if !TaskManager.tasks["Task3"]["acquired"]:
				#print("Talk to aria")
				#return
			#if !TaskManager.tasks["Task8"]["completed"]: #complete registration and buy seeds first
				#print("Complete registrations")
				#return
				#
			print("Open farm :",body.name)
			time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
			if time_manager==null:
				time_manager=get_tree().get_current_scene().find_child("TimeManager",true,false)
			Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
			
			Global.load_farm=true
			Global.player_pos = Vector2(100,1000)
			
			get_tree().current_scene.find_child("DimBG").dim_bg(FARM_SCENE)
			#get_parent().get_parent().get_parent().get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FARM_SCENE)
			
			
