extends Node2D
@onready var control_dial := get_node("LabelCanvas/ControlDialDisplay/TextureRect")
@onready var trust_dial := get_node("LabelCanvas/TrustDialDisplay/TextureRect")
@onready var compliance_dial := get_node("LabelCanvas/ComplianceDialDisplay/TextureRect")
@onready var doubt_dial := get_node("LabelCanvas/DoubtDialDisplay/TextureRect")

var control = 0
var trust = 0
var compliance = 0
var doubt = 0

func _on_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			control_dial.pivot_offset = control_dial.size / 2
			control_dial.rotation+=45
			if control<3:
				control+=1
			else:
				control = 0
			check_alignment()


func _on_trust_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			trust_dial.pivot_offset = trust_dial.size / 2
			trust_dial.rotation+=45
			if trust<3:
				trust+=1
			else:
				trust = 0
			check_alignment()


func _on_compliance_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			compliance_dial.pivot_offset = compliance_dial.size / 2
			compliance_dial.rotation+=45
			if compliance<3:
				compliance+=1
			else:
				compliance = 0
			check_alignment()

func _on_dout_dial_display_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT :   
		if event.pressed:
			doubt_dial.pivot_offset = doubt_dial.size / 2
			doubt_dial.rotation+=45
			if doubt<3:
				doubt+=1
			else:
				doubt = 0
			check_alignment()

func check_alignment():
	if control > compliance and trust>doubt and doubt > compliance and trust > control:
		print("Task COmplete")
