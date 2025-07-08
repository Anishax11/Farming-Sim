extends Label

func _ready() -> void:
	text+=str(Global.day_count)

func update_day_count():
	text="Day: "
	text+=str(Global.day_count)
