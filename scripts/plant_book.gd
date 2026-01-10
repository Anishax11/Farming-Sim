extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var current_page = 0
var total_pages = 10
@onready var right: RichTextLabel = $RightPage/Right
@onready var left: RichTextLabel = $LeftPage/Left
var offset = -1
@onready var back: Button = $Back
var content = {
	page1 ="Excerpt from “On Cultivated Flora and Their Comforts”
(Author unknown, margins annotated in a steady, analytical hand)",

	page2 ="Strawberry Ideal Comfort Range: ~21°C
Strawberries are temperamental not because ",

	page3 ="they are fragile, but because they are honest. They reflect",

	page4 =" their surroundings without restraint. At approximately twenty-one degrees, the plant settles into a quiet productivity — leaves widen, sugar concentrates, and growth remains steady rather than frantic.Below this, sweetness dulls. Above it, the fruit rushes and hollows.",
	page5 ="Pageeeeeeeeee5",
	page6 ="Pageeeeeeeeee6",
	page7 ="Pageeeeeeeeee7",
	page8 ="Pageeeeeeeeee8",
	page9 ="Pageeeeeeeeee9",
	page10 ="Pageeeeeeeeee10"
}
func flip_to_next():
	
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
	if current_page>1:
		left.text = content["page"+str(current_page+offset)]
		if content.has("page"+str(current_page+1+offset)):
			right.text = content["page"+str(current_page+1+offset)]
	elif current_page == 1:
		right.text = content["page"+str(current_page)]
	offset+=1
	#print("Page no:",current_page)

func flip_back():
	
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
	if current_page>1:
		left.text = content["page"+str(current_page+offset-1)]
		if content.has("page"+str(current_page+1+offset)):
			right.text = content["page"+str(current_page+1+offset-1)]
	elif current_page == 1:
		right.text = content["page"+str(current_page)]
		left.text=""
	
	#print("Page no:",current_page)

func _on_next_button_down() -> void:
	flip_to_next()


func _on_back_button_down() -> void:
	flip_back()
