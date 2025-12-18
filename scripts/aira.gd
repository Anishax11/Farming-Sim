extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var farmer
enum State{
	WALK,IDLE,TALK
}
var state = State.IDLE
var speed = 10
var direction = Vector2.ZERO
var decision_time = 0.0
var idle_decision_interval = 3.0 
var walk_decision_interval = 5.0 
var last_direction = Vector2.DOWN	

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
	move_and_slide()
	
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
		state = State.IDLE
		decision_time = idle_decision_interval
		
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
	var dir = direction if state == State.WALK else last_direction

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animated_sprite_2d.play("walk_right" if state == State.WALK else "right")
		else:
			animated_sprite_2d.play("walk_left" if state == State.WALK else "left")
	else:
		if dir.y > 0:
			animated_sprite_2d.play("walk_forward" if state == State.WALK else "front")
		else:
			animated_sprite_2d.play("walk_back" if state == State.WALK else "back")
				
func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			state = State.TALK
			#print("Interact with eiden")
			if Tutorials.interactions["aira"]==false:
				Dialogic.VAR.set("aira_intro",false)
				Tutorials.interactions["aira"]=true
			else:
				Dialogic.VAR.set("aira_intro",true)
			
			Dialogic.VAR.set("random",randi_range(1, 2))
			#print("Random :",Dialogic.VAR.random)
			Dialogic.start("Aira")

func _on_dialogue_ended():
	state = State.IDLE
	


func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
