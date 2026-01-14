extends Node2D

var panel #reference to trade panel

func _ready() -> void:
	var slots_passed=0
	var slot_adjust=1
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
					empty_panel.item_name = string
					slots_passed=0
					slot_adjust=1
					
			slots_passed+=5
			slot_adjust-=1	


func _on_dont_trade_button_down() -> void:
	get_node("NinePatchRect2").visible=false


func _on_trade_button_down() -> void:
	print("Panel path :",panel.get_path())
	if Global.ItemPriceList.has(str(panel.item_name)):
		Global.trade_money+=Global.ItemPriceList[str(panel.item_name)]
		panel.remove_item()
		print("Panel item :",str(panel.item_name))
		
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
