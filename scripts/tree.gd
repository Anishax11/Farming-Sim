extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if int(str(self.name))>1:
		
		animated_sprite_2d.play("thick tree")
