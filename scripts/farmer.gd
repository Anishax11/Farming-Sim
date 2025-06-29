extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory = $Inventory


var speed=70
var direction: Vector2

func _physics_process(delta: float) -> void:
	
		
	if direction==Vector2(0,1):
		#rotation_degrees=0
		animated_sprite_2d.play("forward")
	if direction==Vector2(0,-1):
		#rotation_degrees=0
		animated_sprite_2d.play("backward")
	if direction==Vector2(-1,0):
		#rotation_degrees=0
		animated_sprite_2d.play("left")
	if direction==Vector2(1,0):
		animated_sprite_2d.stop
		#rotation_degrees=0
		animated_sprite_2d.play("right")	
		
	if direction.y==1:
		
		if direction.x==-1:
			animated_sprite_2d.play("left")
			#print("MOving down left")
		if direction.x==1:
			
			animated_sprite_2d.play("right")
			#print("MOving down right")
			

	elif direction.y==-1:
		
		
		if direction.x==-1:
			animated_sprite_2d.play("left")
			#print("MOving up left")
		if direction.x==1:
			animated_sprite_2d.play("right")
			#print("MOving up right")

	#elif direction.x==1:
		#animated_sprite_2d.stop
		#if direction.y==-1:
			#rotation_degrees=-45
			#print("MOving down left")
		#if direction.y==1:
			#rotation_degrees=45
			#print("MOving down right")
			#
	#elif direction.x==-1:
		#animated_sprite_2d.stop
		#if direction.y==-1:
			#rotation_degrees=135
			#print("MOving down left")
		#if direction.y==1:
			#rotation_degrees=45
			#print("MOving down right")
			
	position+=speed*direction*delta
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	direction=Vector2.ZERO
	if Input.is_action_pressed("Up"):
		direction.y-=1
		Global.get_direction(direction)
	if Input.is_action_pressed("Down"):
		direction.y+=1
		Global.get_direction(direction)
	if Input.is_action_pressed("Right"):
		direction.x+=1
		Global.get_direction(direction)
		
	if Input.is_action_pressed("Left"):
		direction.x-=1
		Global.get_direction(direction)
	if Input.is_action_just_pressed("Inventory"):
		inventory.visible = not inventory.visible
		inventory.set_process_input(not inventory.visible)
		
func play_animation():
	animated_sprite_2d.play("hoe_right")
	
func get_direction() ->Vector2:
	#print("PL:",direction)
	return direction

func stop():
	direction=Vector2(0,0)
