extends Node2D

var real_inv
var panel #reference to trade panel
var real_panel  #reference to real inv panel
func _ready() -> void:
	var slots_passed=0
	var slot_adjust=1
	real_inv = get_tree().current_scene.find_child("Inventory",true,false)
	#for i in range(3):
		#Global.inventory_items.append([])
		#for j in range(5):
			#Global.inventory_items[i].append("")
			
	#Global.inventory_items[0][0]="strawberry_seeds"
	#inventory_items[0][0]="seeds"
	#add_to_inventory("seeds")
	#print(inventory_items)
		
	if not Global.inventory_items.is_empty():
		for i in range (3):
			for j in range (5):
				var string=Global.inventory_items[i][j]
					
				if string!="":
					var texture_rect=TextureRect.new()
					texture_rect.texture=Global.get(string+"_image")
					texture_rect.name=string
					if Global.get(string+"_image")==null:
						print(string+" is null")
					print("TEXTURE NAME IS :",string)
					#print("Slot passed:",slots_passed)
					#print("ADJ:",slot_adjust)
					#print("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
					
					var empty_panel=get_node("NinePatchRect/GridContainer/Panel"+str(i+j+slots_passed+slot_adjust))
					empty_panel.add_child(texture_rect)
					print("Item in trade panel :",empty_panel.name," item :",string)
					empty_panel.item_name = string
					slots_passed=0
					slot_adjust=1
					
			slots_passed+=5
			slot_adjust-=1	


func _on_dont_trade_button_down() -> void:
	get_node("NinePatchRect2").visible=false

var price
func _on_trade_button_down() -> void:
	
	print("Panel path :",panel.get_path())
	real_panel = real_inv.find_child(panel.name,true,false)
	if Global.ItemPriceList.has(str(panel.item_name)) and real_panel!=null and real_panel.item_name!=null and real_panel.score!=null:
		if real_panel.score==0:
			real_panel.score = 1
			price = Global.ItemPriceList[real_panel.item_name]*(real_panel.score)*0.1
		else:
			price = Global.ItemPriceList[real_panel.item_name]*(real_panel.score)*00.1
		Global.trade_money+=price
		real_panel.remove_item()
		print("Panel item :",str(real_panel.item_name))
		
	get_node("NinePatchRect2").visible=false

func _on_close_inventory_button_down() -> void:
	visible=false

func remove_item(row,column):
	print("REMOVING ITEM")
	get_node("Trade")
	#Global.inventory_items[row][column]=""
	var panel_no = row*5 + column +1
	var trade_panel = get_node("NinePatchRect/GridContainer/Panel"+str(panel_no))
	trade_panel.remove_item(Global.inventory_items[row][column])
