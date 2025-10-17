extends Button
const SEEDS = preload("res://scenes/seeds.tscn")
func _ready() -> void:
	
		self.connect("pressed", Callable(self, "_on_button_down"))

func _on_button_down() -> void:
	if get_parent().get_parent().get_node("seeds")!=null:
		print("Deactivating prev instance") 
		get_parent().get_parent().get_node("seeds").queue_free()
		#get_parent().get_parent().get_node("seeds").get_node("Label").queue_free()
		
	print("BUYING")
	print("self.name :",self.name)
	#print("PArent:",get_parent())
	var seeds=SEEDS.instantiate()
	seeds.name="seeds"
	seeds.seed_type=self.name
	seeds.global_position=Vector2(1550, 425)
	get_parent().get_parent().add_child(seeds)
	
	#seeds.get_node("Label").text=self.name
