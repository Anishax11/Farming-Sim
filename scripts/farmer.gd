extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var inventory 
var input_disabled
var pause_menu
var speed=70
var direction: Vector2
var points
func _ready():
	
	#print("coin label position :",get_node("Camera2D/CoinLabel").global_position)
	#print(get_path())
	points = Tutorials.PointTracker["Player"]
	display_coins()
	display_points()
	SaveManager.player=self
	pause_menu=get_tree().current_scene.find_child("PauseMenu",true,false)
	inventory = get_node("ClickBlocker")
	
	#print(inventory.get_path())
	#print("Pos save:",SaveManager.player.position)
	#global_position=SaveManager.player.position
	#

func _physics_process(delta: float) -> void:
	
	if input_disabled==true:
		return	
		
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
	print("INput playerr")
	if input_disabled==true:
		return	
	direction=Vector2.ZERO
	if Input.is_action_pressed("Shift"):
		speed=120
	else:
		speed=70	
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
		#print("Open INV ")
		if inventory==null:
			#print("Interior scene")
			inventory = get_parent().get_node("Inventory")
			
		inventory.visible = not inventory.visible
		#print("inventory.visible: ",inventory.visible)
		#inventory.set_process_input(not inventory.visible)
	if Input.is_action_just_pressed("Escape"):
		print("ESCAPE")
		
		get_tree().paused=!get_tree().paused
		#pause_menu.global_position=self.global_position
		pause_menu.visible=!pause_menu.visible
	
	if Input.is_action_just_pressed("Tasks"):
		get_tree().get_current_scene().find_child("TaskManager",true,false).visible=!get_tree().get_current_scene().find_child("TaskManager",true,false).visible
		
	if Input.is_action_just_pressed("TempRegulator") and get_tree().current_scene.name=="farm_scene":# and TaskManager.tasks["Task2"]["completed"]==true:
		get_tree().current_scene.find_child("TemperatureRegulator",true,false).visible=!get_tree().current_scene.find_child("TemperatureRegulator",true,false).visible

func play_animation():
	animated_sprite_2d.play("hoe_right")
	get_tree().paused = !get_tree().paused
	get_node("PauseMenu").global_position=self.global_position
	get_node("PauseMenu").visible = get_tree().paused
func get_direction() ->Vector2:
	#print("PL:",direction)
	return direction

func stop():
	direction=Vector2(0,0)
	
func update_coins(amount:int):
	print("Updating coins...")
	Global.coins_count+=amount	
	get_tree().get_current_scene().find_child("CoinLabel",true,false).text = "Coins :"+str(Global.coins_count)

func update_points(amount:int):
	print("Updating points...")
	points+=amount	
	Tutorials.PointTracker["Player"]+=amount
	get_tree().get_current_scene().find_child("PointsLabel",true,false).text = "Points :"+str(points)
	
		
func display_coins():
	get_tree().get_current_scene().find_child("CoinLabel",true,false).text= "Coins :"+str(Global.coins_count)	
	#get_node("frontyard_scene/LabelCanvas/Control/TextureRect/CoinLabel").text= "Coins :"+str(Global.coins_count)	

func display_points():
	get_tree().get_current_scene().find_child("PointsLabel",true,false).text= "Points :"+str(points)	

func _on_save_button_button_down() -> void:
	SaveManager.save_game()


func _on_load_button_button_down() -> void:
	SaveManager.load_game()
