extends Node2D
var eiden = load("res://scenes/eiden.tscn")
var maya = load("res://scenes/maya.tscn")
var noa = load("res://scenes/noa.tscn")
var aria = load("res://scenes/aria.tscn")
var aira = load("res://scenes/aira.tscn")
var sera = load("res://scenes/sera.tscn") 
var time_manager
var done =false
var camera
@onready var characters: Node2D = $Characters
@onready var judge: CharacterBody2D = $Characters/Judge
@onready var leader_board: StaticBody2D = $LeaderBoard
@onready var bg_music: AudioStreamPlayer2D = $BGMusic
@onready var festival_music: AudioStreamPlayer2D = $FestivalMusic


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
	#player.scale = Vector2(2,2)
	camera = player.get_node("Camera2D")
	camera.limit_bottom = 150
	camera.limit_top = -500
	camera.limit_left = -550
	camera.limit_right = 650
	
	if Global.day_count == 7:
		festival_music.play()
		judge.visible = true
		leader_board.visible = true
		
		leader_board.get_node("AnimatedSprite2D").play("FestLeaderBoard")
		Dialogic.signal_event.connect(_on_dialogic_signal)
		Dialogic.VAR.set("last_scene_start",true)
		Dialogic.start("LastScene")
		get_node("Characters/Sera").queue_free()
		for character in npc_list :
			#print("NPC : ",character)
			var char = npc_list[character].instantiate()
			char.name = character
			char.scale = Vector2(0.7,0.7)
			char.global_position = Vector2(randi_range(-250,250),randi_range(-250,0))
			characters.add_child(char)
			#print("time_manager.current_time :",time_manager.current_time)
	else:
		bg_music.play()
	
		
func _process(delta: float) -> void:
	if Global.day_count==7 and time_manager.current_time>=7 and !done:
		done = true
		leader_board.disable_display = false
		judge.get_node("NavigationAgent2D").target_position = Vector2(50,-400)
		judge.state = judge.State.MOVE_TO_TARGET
		

func _on_count_down_animation_finished() -> void:
	get_node("LeaderBoardDisplay").visible = true


func _on_exit_body_entered(body: Node2D) -> void:
	if Global.player_direction.y==1 and body.name == "Farmer" and !Global.day_count==7:
		body.velocity = Vector2.ZERO
		print("PLayer here")
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		Global.player_pos = Vector2(-725,250)
		Global.player_direction.y = 1
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(MARKET_PLACE)

func _on_dialogic_signal(arg: String):
	if arg=="results_announced":
		print("Res announced")
		get_node("LeaderBoard").disable_display = false
	
