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
var decision_interval = 3.0 
var last_direction = Vector2.DOWN	
var prev_state 
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var free_later

func _ready():
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
	prev_state = state
	var next_pos = navigation_agent_2d.get_next_path_position()
	direction  = (next_pos - global_position).normalized()
	velocity = direction * speed
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		if abs(normal.x) > abs(normal.y):
			print("Collision on X axis (left/right wall)")
			direction.y=randi_range(-1,1)
		else:
			direction.x=randi_range(-1,1)
	move_and_slide()
	if navigation_agent_2d.is_navigation_finished():
		#print("Navigation finished")
		if free_later == true :
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
		decision_time = 5.0
		

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
		state = State.IDLE
		decision_time = decision_interval
		
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
			prev_state = state
			state = State.TALK
			#print("Interact with eiden")
			if Tutorials.interactions["eiden"]==false:
				Dialogic.VAR.set("eiden_intro",false)
				Tutorials.interactions["eiden"]=true
			else:
				Dialogic.VAR.set("eiden_intro",true)
			
			Dialogic.VAR.set("random",randi_range(1, 2))
			#print("Random :",Dialogic.VAR.random)
			Dialogic.start("Eiden")

func _on_dialogue_ended():
	if prev_state == State.MOVE_TO_TARGET:
		state = State.MOVE_TO_TARGET
		return
	state = State.IDLE
	


func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)



	
