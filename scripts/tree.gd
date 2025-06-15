extends Area2D



class_name tree

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	#print(self.global_position)
	if int(str(self.name))>1:
		
		animated_sprite_2d.play("thick tree")
