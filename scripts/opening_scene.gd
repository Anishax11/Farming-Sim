extends CanvasLayer

var time_elapsed = 5.0
var label
var string 
var text ={
	"page_1":"											The greenhouse was abandoned. Before that, it wasn’t a farm. 
																			   It was a research site.

									She worked here alone. Long hours. Precise notes. No interest in visitors.

		   				 				One day, the work stopped. The lights went out. The town moved on.
 																			
																							 I didn’t.

							I told myself I came for the caretaker job. Someone had to keep the place from 
																							 rotting.
																			
																			But that isn’t the real reason.

			 A festival will be held in seven days. This competition will decide whether the greenhouse stays, 
   																				   or gets dismantled.
",
																				
	
	"page_2" :
		" 																If I win, the greenhouse is spared.
							 			   Someone will still come. Keep the water running. Make sure it doesn't go dark.
																					  				 If I lose—

																					it’s dismantled piece by piece,
															until there’s nothing left that remembers her hands.

																								So I work.
																	 				water what’s still alive.
																	I adjust systems I don’t fully understand.
																	   I follow habits she never wrote down,
											  				only left behind in the way things are arranged.

																				Just in case...... she returns.

															  					 And finds it still standing"
	
		
	
}
func _ready() -> void:
	label = get_tree().current_scene.find_child("RichTextLabel",true,false)
	label.visible_characters = 0
	
func _process(delta: float) -> void:
	time_elapsed-=1
	if time_elapsed>=0:
		return
	label.visible_characters+=1
	string=label.visible_characters
	if label.visible_characters == text["page_1"].length():
		print("Over")
		label.text = text["page_2"]
		label.visible_characters = 0
	
	time_elapsed = 5.0
