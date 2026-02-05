extends CharacterBody2D
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
var lock_in_idle
var last_direction = Vector2.DOWN	
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var delay_schedule =false
var free_later = false
var prev_state
var schedule={
	"6" : "maya_home",
	"9" : "Church",
	"16" : "market_entrance",
	"20" : "maya_home"
}
func _ready():
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	#Dialogic.VAR.set("talk_to_maya_task_given",TaskManager.tasks["Task9"]["acquired"])
	Dialogic.VAR.set("talked_to_maya",Tutorials.interactions["talked_to_maya"])
	Dialogic.VAR.set("maya_gives_info",Tutorials.interactions["maya_gives_info"])
	
	
func _physics_process(delta: float) -> void:
	#if state == State.MOVE_TO_TARGET:
		#move_to()
		#return
	if state == State.TALK:
		talk()
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
		State.MOVE_TO_TARGET:
			update_animation()
			move_to()		
	move_and_slide()

func move_to():
	prev_state = State.MOVE_TO_TARGET
	if delay_schedule:
		return
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		state = State.IDLE
			
		
			
	if navigation_agent_2d.is_navigation_finished():
		#print("Navigation finished")
		if free_later:
			queue_free()
		state = State.IDLE
		return
	var next_pos = (navigation_agent_2d.get_next_path_position())
	#print("Next pos ",next_pos)
	direction = (next_pos - global_position).normalized()
	#print("Next dir ",dir)
	
	velocity  = direction * speed
	move_and_slide()
	
func idle_behaviour()	:
	#print("Idle")
	velocity = Vector2.ZERO
	update_animation()
		
	#var action = randi_range(0,10)
	#if action == 1:
		#state = State.WALK
	if lock_in_idle:
		return
	if decision_time <= 0.0:
		state = State.WALK
		decision_time = 5.0
		

func walk():
	#print("Walkk")
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		direction = direction.bounce(normal)
		#print("COllison!!!")
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
	#print("Talking to maya")
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
				
	


	


func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_dialogue_ended():
	farmer.input_disabled = false
	if prev_state == State.MOVE_TO_TARGET:
		
		delay_schedule = false
		state = State.MOVE_TO_TARGET
		return
	state = State.IDLE
	
func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			Dialogic.signal_event.connect(_on_dialogic_signal)
			farmer.input_disabled = true
			delay_schedule = true
			prev_state = state
			state = State.TALK
			talk()
			Dialogic.VAR.set("talk_to_maya_task_given",TaskManager.tasks["Task9"]["acquired"])
			Dialogic.VAR.set("talk_to_bullies_done",TaskManager.tasks["Task10"]["completed"])
			
			if Tutorials.interactions["maya"]==false:
				Dialogic.VAR.set("maya_intro",false)
				Tutorials.interactions["maya"]=true
			else:
				Dialogic.VAR.set("maya_intro",true)
				
			Dialogic.VAR.set("random",randi_range(1, 2))
			print("Random :",Dialogic.VAR.random)
			Dialogic.start("Maya")

func _on_dialogic_signal(arg : String):
	if arg == "talk_to_bullies_task_given":
		#TaskManager.tasks["Task9"]["completed"]=true
		TaskManager.tasks["Task10"]["acquired"]=true
		#get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task9")
		get_tree().get_current_scene().find_child("TaskManager",true,false).add_task("Task10")
		Tutorials.interactions["talked_to_maya"] = true
		
	if arg=="talk_to_maya_task_done":
		Tutorials.interactions["talk_to_maya_task_done"] = true	
		TaskManager.tasks["Task9"]["completed"]=true
		TaskManager.tasks["Task10"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task9")
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task10")
		Tutorials.interactions["maya_gives_info"] = true
		
		
