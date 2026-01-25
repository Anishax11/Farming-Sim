extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var farmer
enum State{
	IDLE,MOVE_TO_TARGET,WALK
}
var lock_in_idle 
var state 
var speed = 10
var direction = Vector2.ZERO
var last_direction = Vector2.DOWN	
var decision_time = 4.0
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var curr_scene
@onready var characters: Node2D = $".."

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
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	
	
func _physics_process(delta: float) -> void:
	decision_time-=1
	match state:
		State.IDLE:
			idle_behaviour()
			
		State.MOVE_TO_TARGET :
			update_animation()
			move_to()
	move_and_slide()

func move_to():
	print("Judge move to called")
	var next_pos = navigation_agent_2d.get_next_path_position()
	direction  = (next_pos - global_position).normalized()
	velocity = direction * speed
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		state = State.IDLE
		
	move_and_slide()
	if navigation_agent_2d.is_navigation_finished():
		state = State.IDLE
		print("LOCK NPC MOVEMENT")
		Dialogic.VAR.set("last_scene_start",false)
		for character in characters.get_children()  :
			character.lock_in_idle = true
			print(character)
		
		Dialogic.VAR.set("judge_announcement",true)
		Dialogic.start("LastScene")
		return
		
	
func idle_behaviour()	:
	animated_sprite_2d.play("idle")
	velocity = Vector2.ZERO
	update_animation()

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
		
			state = State.MOVE_TO_TARGET
			
func update_animation():
	var dir = direction if (state == State.MOVE_TO_TARGET) else last_direction

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("walk" if (state == State.MOVE_TO_TARGET) else "idle")
		else:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("walk" if (state == State.MOVE_TO_TARGET) else "idle")
	
				
				


func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
