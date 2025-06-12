extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed=70
var direction: Vector2

func _physics_process(delta: float) -> void:
	
	if direction==Vector2(0,1):
		rotation_degrees=0
		animated_sprite_2d.play("forward")
	if direction==Vector2(0,-1):
		rotation_degrees=0
		animated_sprite_2d.play("backward")
	if direction==Vector2(-1,0):
		rotation_degrees=0
		animated_sprite_2d.play("left")
	if direction==Vector2(1,0):
		animated_sprite_2d.stop
		rotation_degrees=0
		animated_sprite_2d.play("right")	
		
	if direction.y==1:
		animated_sprite_2d.play("forward")
		if direction.x==-1:
			rotation_degrees=45
			#print("MOving down left")
		if direction.x==1:
			rotation_degrees=-45
			#print("MOving down right")
			

	elif direction.y==-1:
		animated_sprite_2d.play("backward")
		animated_sprite_2d.stop
		if direction.x==-1:
			rotation_degrees=-45
			#print("MOving up left")
		if direction.x==1:
			rotation_degrees=45
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
	if Input.is_action_pressed("Down"):
		direction.y+=1
	if Input.is_action_pressed("Right"):
		direction.x+=1
	if Input.is_action_pressed("Left"):
		direction.x-=1
	
	
	
	
