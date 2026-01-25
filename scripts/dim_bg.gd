extends ColorRect
var tween
var player

func _ready() -> void:
	
	print("Scene loaded")
	tween = create_tween()
	
	tween.tween_property(self, "color", Color(0, 0, 0, 0), 8.0)  # fade out


func dim_bg(scene: PackedScene):
	#print("DIMMM")
	#color = Color(0, 0, 0, 0)
	#tween.tween_property(self, "color", Color(0, 0, 0, 1), 4.0)  # fade out
	#await tween.finished 
	#await get_tree().process_frame
	#await get_tree().change_scene_to_packed(MARKET_PLACE)
	self.color = Color(0, 0, 0, 0)
	self.visible = true

	# Create tween and fade to black over 4 seconds
	var tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 1), 3.0)

	# Wait until the tween finishes properly
	await get_tree().process_frame  # ensures the tween starts
	await tween.finished

	# Optional small pause
	await get_tree().process_frame

	# Change scene
	while(scene==null):
		await get_tree().process_frame
		
	get_tree().change_scene_to_packed(scene)
