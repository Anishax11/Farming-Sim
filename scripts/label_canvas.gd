extends CanvasLayer

#func _ready():
	#print("LabelCanvas texture pos : ",get_node("Control/TextureRect").global_position)
	#var date_label = get_node("TextureRect/DateLabel")
	#var screen = get_viewport().get_visible_rect().size
	#var time_manager= get_node("TextureRect/TimeManager/Label")
	#var coin_label=get_node("TextureRect/CoinLabel")
	#time_manager.scale=Vector2(2,2)
	#date_label.scale=Vector2(2,2)
	#coin_label.scale=Vector2(2,2)
	#get_node("TextureRect").position=Vector2(screen.x +100, 0)
	##date_label.position = Vector2(screen.x - date_label.size.x - 40, 0)
	##time_manager.global_position=Vector2(date_label.global_position.x-8, date_label.global_position.y+32)
	##coin_label.global_position=Vector2(date_label.global_position.x, date_label.global_position.y+64)
	#coin_label.text="Coins : "+str(Global.coins_count)


func _on_plant_book_button_button_down() -> void:
	get_node("PlantBookControl/PlantBook").visible = true
