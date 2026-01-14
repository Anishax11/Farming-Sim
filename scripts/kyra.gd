extends CharacterBody2D


func _ready() -> void:
	if Global.day_count<5:
		queue_free()
