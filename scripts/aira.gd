extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var farmer
enum State{
	WALK,IDLE,TALK,MOVE_TO_TARGET
}
var lock_in_idle = false
var state = State.IDLE
var speed = 10
var direction = Vector2.ZERO
var decision_time = 0.0
var idle_decision_interval = 3.0 
var walk_decision_interval = 5.0 
var last_direction = Vector2.DOWN	
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var free_later
var curr_scene
var prev_state
var delay_schedule = false

#var schedule={
	#"6" : "maya_home",
	#"9" : "library",
	#"10" : "librarian_desk",
	#"17" : "library_entrance",
	#"18" : "library",
	#"19" : "maya_home"
#}


func _ready():
	curr_scene = get_tree().current_scene.name
	if curr_scene == "LibraryInterior":
		lock_in_idle = true
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	
	
func _physics_process(delta: float) -> void:
	
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
	var next_pos = navigation_agent_2d.get_next_path_position()
	direction  = (next_pos - global_position).normalized()
	velocity = direction * speed
	if get_slide_collision_count() > 0:
		lock_in_idle = false
		var collision = get_slide_collision(0)
		state = State.IDLE
		
	move_and_slide()
	if navigation_agent_2d.is_navigation_finished():
		if free_later == true :
			queue_free()
		state = State.IDLE
		return
		
	
func idle_behaviour()	:
	velocity = Vector2.ZERO
	update_animation()
		
	#var action = randi_range(0,10)
	#if action == 1:
		#state = State.WALK
	if	lock_in_idle and !prev_state ==State.MOVE_TO_TARGET:
		#print("Aira locked in idle")
		return
	
		
	if decision_time <= 0.0:
		state = State.WALK
		decision_time = walk_decision_interval
		

func walk():
	#print("Walk")
	if get_slide_collision_count() > 0:
		#print("walk COllsion")
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
			#print("Go to idle")
			state = State.IDLE
			decision_time = idle_decision_interval
		else:
			#print("BAck to move target")
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
				
				
				
func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
		
			farmer.input_disabled = true
			prev_state = state
			delay_schedule = true
			Dialogic.signal_event.connect(_on_dialogic_signal)
			Dialogic.VAR.set("library_scene",(curr_scene=="LibraryInterior"))
			state = State.TALK
			#print("Interact with eiden")
			if Tutorials.interactions["aira"]==false:
				Dialogic.VAR.set("aira_intro",false)
				Tutorials.interactions["aira"]=true
			else:
				Dialogic.VAR.set("aira_intro",true)
			
			if Global.day_count<3:
				Dialogic.VAR.set("random",randi_range(1, 2))
			elif curr_scene == "LibraryInterior":
				Dialogic.VAR.set("random",randi_range(1, 4))
			else:
				Dialogic.VAR.set("random",randi_range(1, 11))
			#print("Random :",Dialogic.VAR.random)
			Dialogic.start("Aira")

func _on_dialogue_ended():
	delay_schedule = false
	farmer.input_disabled = false
	if prev_state == State.MOVE_TO_TARGET:
		state = State.MOVE_TO_TARGET
		return
	state = State.IDLE
	
func _on_dialogic_signal(arg : String):
	if arg=="plant_book_given":
		TaskManager.tasks["Task7"]["completed"] = true
		get_tree().current_scene.find_child("PlantBookButton",true,false).visible = true

func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
