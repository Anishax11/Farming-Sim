extends StaticBody2D


@onready var control_dial_display: Control = $"../LabelCanvas/DialBG/ControlDialDisplay"
@onready var trust_dial_display: Control = $"../LabelCanvas/DialBG/TrustDialDisplay"
@onready var compliance_dial_display: Control = $"../LabelCanvas/DialBG/ComplianceDialDisplay"
@onready var doubt_dial_display: Control = $"../LabelCanvas/DialBG/DoubtDialDisplay"
var dials

func _ready() -> void:
	dials = [control_dial_display,trust_dial_display,compliance_dial_display,doubt_dial_display]

func _on_input_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("INput")
		print(self.name+"DialDisplay")
		for dial in dials:
			if dial.name!=self.name+"DialDisplay" and dial.visible==true:
				print("Make invisible :",dial.name)
				dial.visible=false
				get_tree().current_scene.find_child("DialBG",true,false).visible = !get_tree().current_scene.find_child("DialBG",true,false).visible
		
		get_tree().current_scene.find_child("DialBG",true,false).visible = !get_tree().current_scene.find_child("DialBG",true,false).visible
		get_tree().current_scene.find_child(self.name+"DialDisplay",true,false).visible = !get_tree().current_scene.find_child(self.name+"DialDisplay",true,false).visible
