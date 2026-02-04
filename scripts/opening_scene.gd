extends CanvasLayer

var HOUSE_INTERIOR = load("res://scenes/house_interior.tscn")
@onready var Dim_bg: ColorRect = $CanvasLayer2/DimBG

@onready var timer: Timer = $Timer
@onready var opening_scene_audio: AudioStreamPlayer2D = $OpeningSceneAudio
@onready var good_ending: AudioStreamPlayer2D = $GoodEnding
@onready var bad_ending: AudioStreamPlayer2D = $BadEnding


var MAIN_MENU = load("res://scenes/main_menu.tscn")

var time_elapsed = 200.0
var label
var string 
var page =1
var pause = false
var waiting_time 
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
   																				   or gets dismantled.",
																				
	
	"page_2" :
		"																  		If I win, the greenhouse is spared.
									Someone will still come. Keep the place running. Make sure it doesn't go dark.
																						   	 If I lose—

																	  	   it’s dismantled piece by piece,
												  		until there’s nothing left that remembers her hands.

																						   So I work.
																	 			Water what’s still alive.
															   I salvage systems I don’t fully understand.
																   I follow habits she never wrote down,
											  		  	   only left behind in the way things are arranged.

																			 Just in case..... she returns.

															  				  And finds it still standing.",
"page_3":"	                                                                        The festival ends quietly.

																		   The winner is announced.
																						It isn’t me.

																The greenhouse is no longer necessary.

										They say it will be dismantled carefully. That nothing will be wasted.
																		
																 I return once more before they begin.

							   The systems are already shut down. The air is still. The plants lean toward nothing.

			 I stand there longer than I should. There isn’t anything left to tend. When I leave, I don’t look back.

															Some places aren’t meant to be waited for.
",
"page_4" :"																					The festival ends.

																	 My name is called. Once. Clearly.

									   The greenhouse is approved. Not as a relic.  Not as a compromise.

																		   They say it has a future.

																	  Whatever she was reaching for—
																				  it didn’t disappear.

																						   It stayed.
																		   In the soil. In the work.  In me.

																					  So I keep going.
												 Somewhere along the way, it stopped being hers alone.
"
	
		
	
}
func _ready() -> void:
	label = get_tree().current_scene.find_child("RichTextLabel",true,false)
	if Global.day_count == 7:
		if Tutorials.PointTracker["You"]>= 5000:
			good_ending.play()
			label.text =  text["page_4"]
			page = 4
		else:
			bad_ending.play()
			label.text =  text["page_3"]
			page =3 
	else:
		opening_scene_audio.play()	
		
	Global.music_fade_in()	
	 
	#label.text =  text["page_1"]
	label.visible_characters = 0
	

func _process(delta: float) -> void:
	if pause:
		#print("Paused")
		return
	time_elapsed-=1
	if time_elapsed>=0:
		#print(time_elapsed)
		return
	
	label.visible_characters+=1
	#print("Visible characters : ",label.visible_characters)	
	string=label.visible_characters
	
	if label.visible_characters == text["page_1"].length() and page==1:
		print("PAge 1 over")
		pause = true
		
		timer.timeout.connect(_on_timer_timeout)
		timer.wait_time = 5.0
		timer.start()
		
	elif label.visible_characters == text["page_2"].length() and page==2:
		print("Page 2 over")
		pause = true
		timer.wait_time = 5.0
		timer.timeout.connect(_on_timer2_timeout)
		timer.wait_time = 5.0
		timer.start()
	elif (label.visible_characters == text["page_3"].length() and page==3) or (label.visible_characters == text["page_4"].length() and page==4) :
		print("Page 3/4 over")
		pause = true
		timer.wait_time = 5.0
		timer.timeout.connect(_on_timer3_timeout)
		timer.wait_time = 5.0
		timer.start()
	time_elapsed = 5.0
	
func _on_timer_timeout():
	if page==1:
		print("TImer1 timeout")
		label.visible_characters = 0
		label.text = text["page_2"]
		page += 1
		pause = false


func _on_timer2_timeout():
	if page ==3 or page ==4:
		return
	print("Timer 2 timeout")
	#label.visible_characters = 0
	
	var tween=create_tween()
	tween.tween_property(opening_scene_audio,"volume_db",-40,7.0)
	
	var tween2 = create_tween()
	tween2.tween_property(Dim_bg, "color", Color(0, 0, 0, 1), 7.0)

	

	
	
func _on_timer3_timeout():
	print("Timer 3 timeout")
	#label.visible_characters = 0
	if page ==3:
		var tween=create_tween()
		tween.tween_property(bad_ending,"volume_db",-40,7.0)
	else:
		var tween=create_tween()
		tween.tween_property(good_ending,"volume_db",-40,7.0)
	
	var tween2 = create_tween()
	tween2.tween_property(Dim_bg, "color", Color(0, 0, 0, 1), 7.0)
	
	while(Dim_bg.color!=Color(0, 0, 0, 1)):
		await get_tree().process_frame
	
	get_tree().change_scene_to_packed(MAIN_MENU)
