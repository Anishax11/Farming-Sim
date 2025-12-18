extends Node2D

var player 
func _ready() -> void:
	Global.music_fade_in()
	player = get_node("Farmer")
	player.animated_sprite_2d.play("backward")
	if Global.day_count == 7:
		get_node("Boxes").queue_free()
		get_node("CountDown").play("default")
		


func _on_count_down_animation_finished() -> void:
	get_node("LeaderBoardDisplay").visible = true
