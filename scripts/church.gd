extends Area2D
var CHURCH_INTERIOR = load("res://scenes/church_interior.tscn")
var time_manager
var Dim_bg
func _ready() -> void:
	
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	Dim_bg = get_parent().get_node("Farmer/CanvasLayer2/DimBG")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name!="Farmer" :
		return
	#if !TaskManager.tasks["Task3"]["acquired"]:
				#print("Talk to aria")
				#return
	#if Global.player_direction.y==-1:
		#if body.name!="Farmer":
				#return
		#if !TaskManager.tasks["Task3"]["acquired"]:
				#print("Talk to aria")
				#return
		#if !TaskManager.tasks["Task3"]["completed"]: #complete registration and buy seeds first
				#print("Complete registrations")
				#return
		#Global.player_pos = Vector2(-214, -187)
	print(self.name)
	Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
	Global.music_fade_out()
	Dim_bg.dim_bg(CHURCH_INTERIOR)
