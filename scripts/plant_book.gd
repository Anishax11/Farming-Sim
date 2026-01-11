extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var current_page = 0
var total_pages = 10
@onready var right: RichTextLabel = $RightPage/Right
@onready var left: RichTextLabel = $LeftPage/Left
var offset = -1
@onready var back: Button = $Back
var direction # next/back button click tracker
var content = {
	page1 ="
Excerpt from “On Cultivated Flora and Their Comforts”

  ~Unknown
	   Author ",

	page2 ="Strawberry

Ideal Temperatu-re: ~21°C
Difficulty: Moderate

Strawberries demand consistency.Temperature fluctuations quickly dull",

	page3 ="sweetness, though careful control is generously rewarded. 

It is a plant that teaches restraint.",

	page4 ="Pumpkin

Ideal Temperature: ~24°C
Difficulty: High

Pumpkins hunger for heat and stability.
When warmth is precise,growth",

	page5 ="accelerates dramaticall-y. When mismanaged, quality collapses just as fast.
Powerful yields favor discipline.",
	page6 ="Potato

Ideal Temperature: ~17°C
Difficulty: Low

Hardy and forgiving, potatoes tolerate neglect better than most.",
	page7 ="They endure cooler air and uneven conditions with little complaint.Reliable, but unambitiou-s",
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
	direction = "back"
	if current_page == 1:
		animated_sprite_2d.play("close_book")
		back.visible = false
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
	flip_to_next()


func _on_back_button_down() -> void:
	flip_back()


func _on_animated_sprite_2d_animation_finished() -> void:
	if direction =="next":#Next button clicked
		
		if current_page>1:
			
			if content.has("page"+str(current_page+offset)):
				left.text = content["page"+str(current_page+offset)]
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


func _on_animated_sprite_2d_animation_changed() -> void:
	if left!=null:
		left.text=""
	if right!=null:
		right.text=""
