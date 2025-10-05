extends Label

func _ready() -> void:
	text="Day:"+str(Global.day_count)
	#print("DATE LABEL HERE")

func update_day_count():
	text="Day:"+str(Global.day_count)

#func _process(delta: float) -> void:
	#print("POsition:",global_position)
