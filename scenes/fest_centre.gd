extends Node2D
var eiden = load("res://scenes/eiden.tscn")
var maya = load("res://scenes/maya.tscn")
var noa = load("res://scenes/noa.tscn")
var aria = load("res://scenes/aria.tscn")
var aira = load("res://scenes/aira.tscn")
var sera = load("res://scenes/sera.tscn") 
var time_manager
const MARKET_PLACE = preload("res://scenes/market_place.tscn")
var npc_list ={
	"aria" : aria,
	"aira" :aira,
	"eiden" : eiden,
	"sera" : sera
}

var player 
func _ready() -> void:
	time_manager = get_tree().get_current_scene().find_child("TimeManager",true,false)
	
	Global.music_fade_in()
	player = get_node("Farmer")
	player.animated_sprite_2d.play("backward")
	player.scale = Vector2(2,2)
	if Global.day_count == 7:
		get_node("Characters/Sera").queue_free()
		get_node("Boxes").queue_free()
		for character in npc_list :
			print("NPC : ",character)
			var char = npc_list[character].instantiate()
			char.name = character
			#char.scale = Vector2(2,2)
			char.global_position = Vector2(randi_range(-100,100),randi_range(-100,50))
			add_child(char)
			print("time_manager.current_time :",time_manager.current_time)
	
		


func _on_count_down_animation_finished() -> void:
	get_node("LeaderBoardDisplay").visible = true


func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==1 and body.name == "Farmer":
		print("PLayer here")
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		Global.player_pos = Vector2(-475,25)
		Global.player_direction.y = 1
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)
