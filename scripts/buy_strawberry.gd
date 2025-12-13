extends Button
const SEEDS = preload("res://scenes/seeds.tscn")
const SEED_BUTTON = preload("res://scenes/seed_button.tscn")
var strawberry_bought =false
var potato_bought =false
var pumpkin_bought =false
func _ready() -> void:
		mouse_default_cursor_shape=Control.CursorShape.CURSOR_POINTING_HAND
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
	TaskManager.seeds_bought[self.name]=true
	if TaskManager.seeds_bought["strawberry"]==true and TaskManager.seeds_bought["potato"]==true and TaskManager.seeds_bought["pumpkin"]==true:
		TaskManager.tasks["Task1"]["completed"]=true
		print("Task 1 complete")
	seeds.name="seeds"
	seeds.seed_type=self.name
	seeds.get_node("AnimatedSprite2D").play(self.name)
	seeds.global_position=Vector2(1550, 425)
	get_parent().get_parent().add_child(seeds)
	#seeds.get_node("Label").text=self.name
