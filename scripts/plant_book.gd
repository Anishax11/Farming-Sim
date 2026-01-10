extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var current_page = 0
var total_pages = 5
@onready var back: Button = $Back

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
	print("Page no:",current_page)

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
	print("Page no:",current_page)

func _on_next_button_down() -> void:
	flip_to_next()


func _on_back_button_down() -> void:
	flip_back()
