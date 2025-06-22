extends Node

var grass_clicked=false
var soil_clicked=false
var panel_clicked=false
var player_direction
#func till_soil(player):
	
	#if abs(position-location)<=16:
		#queue_free()

	
func get_direction(direction) :
	player_direction=direction
	#print("player_direction",player_direction)
