extends Node2D
@onready var compliance_dial_display: Control = $LabelCanvas/DialBG/ComplianceDialDisplay
@onready var trust_dial_display: Control = $LabelCanvas/DialBG/TrustDialDisplay
@onready var control_dial_display: Control = $LabelCanvas/DialBG/ControlDialDisplay
@onready var doubt_dial_display: Control = $LabelCanvas/DialBG/DoubtDialDisplay

var FRONTYARD_SCENE = load("res://scenes/frontyard_scene.tscn")
var control = 0
var trust = 0
var compliance = 0
var doubt = 0
var time_manager
func _ready() -> void:
	time_manager = get_tree().current_scene.find_child("TimeManager",true,false)
	
func _on_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			#control_dial_display.pivot_offset = control_dial_display.size / 2
			if control_dial_display.rotation>=360:
				control_dial_display.rotation = 0
			control_dial_display.rotation+=90
			print("Control Rotation ")
			if control<3:
				control+=1
			else:
				control = 0
			check_alignment()


func _on_trust_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Trust Rotation  ")
			if trust_dial_display.rotation>=360:
				trust_dial_display.rotation = 0
			trust_dial_display.rotation+=90
			if trust<3:
				trust+=1
			else:
				trust = 0
			check_alignment()


func _on_compliance_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Compliance Rotation ")
			if compliance_dial_display.rotation>=360:
				compliance_dial_display.rotation = 0
			compliance_dial_display.rotation+=90
			if compliance<3:
				compliance+=1
			else:
				compliance = 0
			check_alignment()

func _on_dout_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			print("Doubt Rotation : ")
			if doubt_dial_display.rotation>=360:
				doubt_dial_display.rotation = 0
			doubt_dial_display.rotation+=90
			if doubt<3:
				doubt+=1
			else:
				doubt = 0
			check_alignment()

func check_alignment():
	
	if control > compliance and trust>doubt and doubt > compliance and trust > control:
		print("Task COmplete")
		TaskManager.tasks["Task6"]["completed"]=true
		get_tree().get_current_scene().find_child("TaskManager",true,false).remove_task("Task6")
	#print("Rotation : ",control_dial_display.rotation )

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name!="Farmer" :
		return
	
	if Global.player_direction.y==1:
		#Global.player_pos = Vector2(-214, -187)
		Global.track_time(time_manager.current_time,time_manager.time_to_change_tint,time_manager.color_rect.i,time_manager.minutes)
		Global.music_fade_out()
		get_node("Farmer/CanvasLayer2/DimBG").dim_bg(FRONTYARD_SCENE)
