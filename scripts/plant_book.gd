extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var current_page = 0
var total_pages = 10
var offset = -1
@onready var right: RichTextLabel = $RightPage/Right
@onready var left: RichTextLabel = $LeftPage/Left
@onready var next: TextureButton = $Next
@onready var back: TextureButton = $Back
var direction # next/back button click tracker

var content = {
	page1 ="
Excerpts from “On Cultivated Flora and Their Comforts”

  ~Unknown
	   Author ",

	page2 ="Strawberry

Ideal Temperature: ~25°C

Difficulty: Moderate

Strawberries demand consistency. Exposure to Myrion alters sugar structure,",

	page3 ="sharpening sweetness while narrowing tolerance.

A rewarding crop—if the environment is respected.",

	page4 ="Pumpkin

Ideal Temperature: ~22°C

Difficulty: High

Pumpkins react violently to Myrion-rich soil. When conditions align, growth

",

	page5 ="accelerates unnaturally. Instability causes rapid collapse.

Power favors discipline—and exact control.",
	page6 ="Potato

Ideal Temperature: ~17°C

Difficulty: Low

Potatoes absorb Myrion without visible mutation, stabilizing soil ",

	page7 ="conditions around them. Yield remains consistent despite interference.

Reliable. Quietly essential.",

page8 ="Experimental Hybrid

Ideal Temperature: ~25°C
Difficulty: Unknown

Grown with purified Myrion alone. Cyan pigment observed across",

page9 = "all growth stages. Responds as if alive to regulation itself.

Further study discouraged.
"
	}
func flip_to_next():
	direction = "next"
	if current_page == 0: #book closed
		animated_sprite_2d.play("open_book")
		back.visible = true
	elif current_page == 1:
		animated_sprite_2d.play("first_page_front")
	elif current_page == total_pages-1:
		animated_sprite_2d.play("last_page_front")
	elif current_page == total_pages:
		animated_sprite_2d.play("close_book")
		current_page = 0
		offset = -2 #set to -1 later in animation finished func
		back.visible = false
		return
	else:
		animated_sprite_2d.play("middle_page_front")
	current_page+=1
	#if current_page>1:
		#if content.has("page"+str(current_page+offset)):
			#left.text = content["page"+str(current_page+offset)]
		#else:
			#left.text = ""
		#if content.has("page"+str(current_page+1+offset)):
			#right.text = content["page"+str(current_page+1+offset)]
		#else:
			#right.text =""
	#elif current_page == 1:
		#right.text = content["page"+str(current_page)]
	

func flip_back():
	audio_stream_player_2d.play()
	direction = "back"
	if current_page == 1:
		animated_sprite_2d.play("close_book")
		back.visible = false
		current_page = 0
		offset = 0
	elif current_page == 2:
		animated_sprite_2d.play("first_page_back")#go back to 1st page
	elif current_page == total_pages:
		animated_sprite_2d.play("last_page_back")
	else:
		animated_sprite_2d.play("middle_page_back")
	current_page-=1
	offset-=1
	#if current_page>1:
		#left.text = content["page"+str(current_page+offset-1)]
		#if content.has("page"+str(current_page+1+offset)):
			#right.text = content["page"+str(current_page+1+offset-1)]
	#elif current_page == 1:
		#right.text = content["page"+str(current_page)]
		#left.text=""
	
	#print("Page no:",current_page)

func _on_next_button_down() -> void:
	audio_stream_player_2d.play()
	next.visible=false
	back.visible=false
	if left!=null:
		left.text=""
	if right!=null:
		right.text=""
	flip_to_next()


func _on_back_button_down() -> void:
	back.visible=false
	next.visible=false
	if left!=null:
		left.text=""
	if right!=null:
		right.text=""
	flip_back()


func _on_animated_sprite_2d_animation_finished() -> void:
	if direction =="next":#Next button clicked
		print("Curr + offset :",current_page+offset)
		if current_page>1:
			
			if content.has("page"+str(current_page+offset)):
				left.text = content["page"+str(current_page+offset)]
				print("Left page dic :",current_page+offset)
			else:
				left.text = ""
			if content.has("page"+str(current_page+1+offset)):
				right.text = content["page"+str(current_page+1+offset)]
			else:
				right.text =""
		elif current_page == 1:
			right.text = content["page"+str(current_page)]
		offset+=1
	else: #Back button clicked
		if current_page>1:
			if content.has("page"+str(current_page+offset-1)):
				left.text = content["page"+str(current_page+offset-1)]
			else:
				left.text = ""
			if content.has("page"+str(current_page+offset)):
				right.text = content["page"+str(current_page+offset)]
			else:
				right.text = ""
		elif current_page == 1:
				right.text = content["page"+str(current_page)]
				left.text=""
	
	next.visible=true
	back.visible=true

	


func _on_close_button_button_down() -> void:
	visible = false
