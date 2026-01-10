extends CharacterBody2D
var rng := RandomNumberGenerator.new()
var aria_strawberry_task_given 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var farmer
enum State{
	WALK,IDLE,TALK,MOVE_TO_TARGET
}
var state = State.IDLE
var speed = 10
var direction = Vector2.ZERO
var decision_time = 0.0
var idle_decision_interval = 3.0 
var walk_decision_interval = 5.0 
var last_direction = Vector2.DOWN	
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var free_later
var delay_schedule = false
var prev_state

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	if Global.day_count == 1 and !TaskManager.tasks["Task3"]["acquired"]:
		delay_schedule = true
		#state = State.TALK
		global_position = Vector2(100,550)
	if Global.day_count>2 and TaskManager.tasks["Task2"]["acquired"]==true:
		for i in range (3):
			for j in range (5):
				var string=Global.inventory_items[i][j]
					
				if string=="strawberry":
					Dialogic.VAR.set("aria_task_done",true)
					print("Aria task done set to true")
			
	
func _physics_process(delta: float) -> void:
	if delay_schedule:
		return
		
	decision_time -=delta
	match state:
		State.IDLE:
			idle_behaviour()
		State.WALK:
			update_animation()
			walk()
		State.TALK:
			talk()	
		State.MOVE_TO_TARGET :
			update_animation()
			move_to()
	move_and_slide()

func move_to():
	prev_state = State.MOVE_TO_TARGET
	if delay_schedule:
		return
		
	var next_pos  = navigation_agent_2d.get_next_path_position()
	direction  = (next_pos - global_position).normalized()
	velocity = direction * speed
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		state = State.IDLE
			
	move_and_slide()
	if navigation_agent_2d.is_navigation_finished():
		#print("Navigation finished")
		if free_later == true :
			print("Freeee")
			queue_free()
		state = State.IDLE
		return
		
func idle_behaviour()	:
	#print("Idle")
	velocity = Vector2.ZERO
	update_animation()
		
	#var action = randi_range(0,10)
	#if action == 1:
		#state = State.WALK
	if decision_time <= 0.0:
		state = State.WALK
		decision_time = walk_decision_interval
		

func walk():
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		direction = direction.bounce(normal)
		
		#update_animation()
				
	var change_dir = randi_range(0,100)
	if change_dir == 1:
		direction.x = randi_range(-1,1)
		direction.y = randi_range(-1,1)
		if direction != Vector2.ZERO:
			last_direction = direction
		update_animation()
		
	direction = direction.normalized()	
	velocity = direction * speed
	
	
	if decision_time <= 0.0:
		if !prev_state == State.MOVE_TO_TARGET:
			state = State.IDLE
			decision_time = idle_decision_interval
		else:
			state = State.MOVE_TO_TARGET
		
func talk():
	velocity = Vector2.ZERO
	animated_sprite_2d.stop()
	if farmer.position.x > position.x:
		animated_sprite_2d.play("right")
	else:
		animated_sprite_2d.play("left")
		
	if 	abs(farmer.position.y - position.y) > 20:
		if farmer.position.y > position.y:
			animated_sprite_2d.play("front")
		else:
			animated_sprite_2d.play("back")

func update_animation():
	var dir = direction if (state == State.WALK or state == State.MOVE_TO_TARGET) else last_direction

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animated_sprite_2d.play("walk_right" if (state == State.WALK or state == State.MOVE_TO_TARGET) else "right")
		else:
			animated_sprite_2d.play("walk_left" if (state == State.WALK or state == State.MOVE_TO_TARGET) else "left")
	else:
		if dir.y > 0:
			animated_sprite_2d.play("walk_forward" if (state == State.WALK or state == State.MOVE_TO_TARGET) else "front")
		else:
			animated_sprite_2d.play("walk_back" if (state == State.WALK or state == State.MOVE_TO_TARGET) else "back")
				
				

func _on_dialogue_ended():
	if prev_state == State.MOVE_TO_TARGET:
		delay_schedule = false
		state = State.MOVE_TO_TARGET
		return
	state = State.IDLE
	

func _on_dialogic_signal(argument : String):
	if argument=="aria_strawberry_task_accepted":
		if !TaskManager.tasks["Task2"]["acquired"]:
			print("Aria task accepted")
			get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task2")
			Tutorials.interactions["aria_strawberry_task_given"]=true
			
	elif argument== "aria_strawberry_task_complete":
		print("Task Complete!")
		TaskManager.tasks["Task2"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task2")
		
		for i in range (3): #Delete strawberry from inv
			for j in range (5):
				var string=Global.inventory_items[i][j]
				if string=="strawberry":
					var number = i*5 +1+j
					get_tree().current_scene.find_child("Panel"+str(number),true,false).remove_item()
					
	
	elif argument== "Task3_acquired":
		print("task one acquired")
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task3")


func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if state == State.MOVE_TO_TARGET:
				prev_state = State.MOVE_TO_TARGET
			delay_schedule = true
			state = State.TALK
			Dialogic.signal_event.connect(_on_dialogic_signal)
			Dialogic.VAR.set("aria_strawberry_task_given",Tutorials.interactions["aria_strawberry_task_given"])
			Dialogic.VAR.set("aria_intro",Tutorials.interactions["aria"])
			if Tutorials.interactions["aria"]==false:
				print("aria intro")
				#Dialogic.start("AriaSeedShopDirections")
				#print("Interact with aria")
				Tutorials.interactions["aria"]=true
			
				#rng.randomize()
			print("Strawberry task :",Dialogic.VAR.aria_strawberry_task_given)
			Dialogic.VAR.set("random",randi_range(1, 2))
			print("Randome :",Dialogic.VAR.random)
			Dialogic.start("Aria")



func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
