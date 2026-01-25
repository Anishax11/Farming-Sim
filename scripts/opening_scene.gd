extends CanvasLayer

var HOUSE_INTERIOR = load("res://scenes/house_interior.tscn")
@onready var Dim_bg: ColorRect = $CanvasLayer2/DimBG
@onready var timer: Timer = $Timer

var time_elapsed = 15.0
var label
var string 
var page =1
var pause = false

var text ={
	"page_1":"											The greenhouse was abandoned. Before that, it wasn’t a farm. 
																			   It was a research site.

	 She worked here alone. Long hours. No interest in visitors. Every result chased until it broke or she did.

		   				 				One day, the work stopped. The lights went out. The town moved on.
 																			
																							 I didn’t.

							I told myself I came for the caretaker job. Someone had to keep the place from 
																							 rotting.
																			
																			But that isn’t the real reason.

			 A festival will be held in seven days. This competition will decide whether the greenhouse stays, 
   																				   or gets dismantled.
",
																				
	
	"page_2" :
		"																  			 If I win, the greenhouse is spared.
										Someone will still come. Keep the water running. Make sure it doesn't go dark.
																						   			If I lose—

																	  			it’s dismantled piece by piece,
												  			until there’s nothing left that remembers her hands.

																						 		 	So I work.
																	 		 			water what’s still alive.
																		 I adjust systems I don’t fully understand.
																			I follow habits she never wrote down,
											  		  		  	 only left behind in the way things are arranged.

																					Just in case..... she returns.

															  			 			And finds it still standing"
	
		
	
}
func _ready() -> void:
	label = get_tree().current_scene.find_child("RichTextLabel",true,false)
	#label.text =  text["page_1"]
	label.visible_characters = 0
	
func _process(delta: float) -> void:
	if pause:
		print("Paused")
		return
	time_elapsed-=1
	if time_elapsed>=0:
		return
	label.visible_characters+=1
	string=label.visible_characters
	
	if label.visible_characters == text["page_1"].length() and page==1:
		print("PAge 1 over")
		pause = true
		page += 1
		timer.timeout.connect(_on_timer_timeout)
		timer.wait_time = 3.0
		timer.start()
		
	elif label.visible_characters == text["page_2"].length() and page==2:
		print("Page 2 over")
		pause = true
		timer.wait_time = 3.0
		timer.timeout.connect(_on_timer2_timeout)
		timer.wait_time = 3.0
		timer.start()
	
func _on_timer_timeout():
	print("TImer1 timeout")
	label.visible_characters = 0
	label.text = text["page_2"]
	pause = false


func _on_timer2_timeout():
	print("Timer 2 timeout")
	label.visible_characters = 0
	#Dim_bg.visiblw = true
	Dim_bg.dim_bg(HOUSE_INTERIOR)
