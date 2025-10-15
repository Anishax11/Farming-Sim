extends Camera2D

func _ready():
	make_current()
	print("Current camera:", get_viewport().get_camera_2d())
