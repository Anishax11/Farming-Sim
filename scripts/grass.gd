extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var clicked=false
var distance
var player

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	player = get_tree().current_scene.find_child("Farmer",true,false)
	if PlantTracker.cut_grass.has(self.name):
		queue_free()
	
	
	#
	#print(get_path())
#func _process(delta: float) -> void:
	#pass
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_RIGHT:
		distance=position.distance_to(player.position)
		if distance>100:
			print("Return, player dist greater than `100")
			return
		audio_stream_player_2d.play()
		PlantTracker.cut_grass[self.name] = ""
		
		if event.pressed:
			#print("grass pressed")
		
			Global.grass_clicked=true
			#Global.grass_held=true
			
		if !event.pressed:
			#print("Left grass button")
			Global.grass_clicked=false
			#Global.grass_held=false
			queue_free()
			
	elif  event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed:
			print("grass pressed")
			Dialogic.VAR.set("cut_grass",true)
			Dialogic.start("GeneralMessages")
		
			
			
	#if event is InputEventMouseMotion:
		#
		#if Global.grass_held==true and Global.grass_clicked==true and animated_sprite_2d!=null:
			#Global.grass_clicked=false
			#print("HELD")
			#animated_sprite_2d.queue_free()
		#
		#elif Global.grass_held==true and Global.grass_clicked!=true and animated_sprite_2d!=null:
			#Global.grass_clicked=false
			#print("HELD")
			#queue_free()	
			
		#if Global.grass_clicked==false:
			#print("NOT CLICKED")
			
		#if Global.grass_held==true and Global.grass_clicked==false:
			#Global.grass_clicked=false
			#Global.grass_held=true
			#print("MOVING")
			#queue_free()
			
		#if 	Global.first_grass==self:
			#
			##print("FIRST:",Global.first_grass)
			#print("! Grass")

#func _process(delta: float) -> void:
	#print(clicked)

#
#func _on_body_entered(body: Node2D) -> void:
	#print("Entered")
	#var player=get_node("/root/Game/Farmer")
	#if body == player:
		#
	#
		#player.stop()
