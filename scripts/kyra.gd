extends CharacterBody2D
var sucess_rate = 0
var farmer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	farmer = get_tree().current_scene.find_child("Farmer",true,false)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	if Global.day_count<5:
		queue_free()



func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Tutorials.interactions["talked_to_bully"]:
		return
	farmer.input_disabled = true
	animated_sprite_2d.play("talk")
	Dialogic.VAR.set("talk_to_bullies_given",TaskManager.tasks["Task10"]["acquired"])

	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("Kyra")

func _on_dialogic_signal(arg : String):
	if arg =="increment":
		sucess_rate+=1
		
	
	if arg =="decrement":
		sucess_rate-=1
		Dialogic.VAR.set("kyra_sucess_rate",sucess_rate)
		
	if arg =="talked_to_bully" and sucess_rate>=3:
		TaskManager.tasks["Task10"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task10")
		Tutorials.interactions["talked_to_bully"] = true
		animated_sprite_2d.play("idle")

func _on_timeline_ended():
	farmer.input_disabled = false
	
func _on_interact_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_interact_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
