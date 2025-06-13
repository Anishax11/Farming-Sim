extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var clicked=false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed:
			print("pressed")
			Global.grass_clicked=true
		else:
			Global.grass_clicked=false
	if event is InputEventMouseMotion:
		
		if Global.grass_clicked==true:
			animated_sprite_2d.play("Soil")

#func _process(delta: float) -> void:
	#print(clicked)
