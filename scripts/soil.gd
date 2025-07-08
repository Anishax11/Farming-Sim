extends Area2D


class_name Soil
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var tilled=false
var adjusted=false
var planted=false
var distance
var inventory

var watered=false
func _ready() -> void:
	inventory=get_node("/root/Game/farm_scene/Farmer/Inventory")
	if randi_range(0,7)==3:
		animated_sprite_2d.play("untilled_rock")
		#print(get_path())

#func _on_area_entered(area: Area2D) -> void:
	#
	#if !area is Soil: 
		#print(area.name)
		#queue_free()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed and get_node("Grass")==null:
			
			
			var soil_pos=Vector2( int(position.x / 8) * 8,int(position.y / 8) * 8 )
			var player=get_node("/root/Game/farm_scene/Farmer")
			var player_pos=Vector2( int(player.position.x / 8) * 8,int(player.position.y / 8) * 8 )
			distance=soil_pos.distance_to(player_pos)
			print(distance)
			
			# CODE FOR GROWING PLANT
			if distance<18 and planted==true and panel.water_equipped==true:
				Global.plant_watered(self)
				print("Plant watered")
				
		
			
			#CODE FOR PLANTATION
			print(panel.seeds_equipped)
			if distance<18 and tilled==true and panel.seeds_equipped==true and inventory.seeds_count>0:
				print("Plant ")	
				planted=true
				print("Seeds count before:",inventory.seeds_count)
				inventory.seeds_count-=1
				print("Seeds count:",inventory.seeds_count)
				player.get_node("AnimatedSprite2D").play("seeds")
				if animated_sprite_2d.animation=="tilled":
					animated_sprite_2d.play("circle_seeds")
				elif animated_sprite_2d.animation=="rect_tilled":
					animated_sprite_2d.play("seeds")
				print(animated_sprite_2d.animation)
				Global.save_tilled_soil(self,animated_sprite_2d.animation)
				
			#CODE FOR TILLING
				
			if distance<=18 and !tilled:
				print(self.name)
				if Global.player_direction==Vector2(1,0):
					rotation_degrees=90 #rotates animation of tilled soil towards right 
					player.get_node("AnimatedSprite2D").play("hoe_right")
					
				if Global.player_direction==Vector2(-1,0):
					rotation_degrees=-90
					
					player.get_node("AnimatedSprite2D").play("hoe_left")
					
				if Global.player_direction==Vector2(0,1):
					rotation_degrees=180
					player.get_node("AnimatedSprite2D").play("hoe_front")
			
				Global.soil_clicked=true
				if adjusted!=true:
					animated_sprite_2d.scale.y=0.2
					animated_sprite_2d.play("tilled")
					
					Global.save_tilled_soil(self,animated_sprite_2d.animation)
					
				var text = self.name
				var regex = RegEx.new()
				regex.compile(r"\d+")  # Matches one or more digits
				var result = regex.search(text)

				if result:
					var number = int(result.get_string(0))
					if Global.player_direction==Vector2(1,0): 
						if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).get_node("AnimatedSprite2D").scale.y=0.21
							
							if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).planted==true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).get_node("AnimatedSprite2D").play("seeds")
							elif get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).adjusted!=true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).get_node("AnimatedSprite2D").play("rect_tilled")
								print("RECT")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-1)).adjusted=true
							
					if Global.player_direction==Vector2(-1,0):
						if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).tilled==true  :
							print("Prev tilled")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).get_node("CollisionShape2D").scale.y=0.21
							if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).planted==true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).get_node("AnimatedSprite2D").play("seeds")
								print("SEEDS")
							elif get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).adjusted!=true:
								
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).get_node("AnimatedSprite2D").play("rect_tilled")
								print("RECT")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+1)).adjusted=true
					
								
					if Global.player_direction==Vector2(0,1):
						if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).get_node("AnimatedSprite2D").scale.y=0.21
							
							if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).planted==true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).get_node("AnimatedSprite2D").play("seeds")
							elif get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).adjusted!=true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).get_node("AnimatedSprite2D").play("rect_tilled")
								print("RECT")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number-39)).adjusted=true
					
					if Global.player_direction==Vector2(0,-1):
						
						if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).get_node("AnimatedSprite2D").scale.y=0.17
							
							if get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).planted==true:
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).get_node("AnimatedSprite2D").play("seeds")
								print("SEEDS")
							elif get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).adjusted!=true :
								get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).get_node("AnimatedSprite2D").play("rect_tilled")
								print("RECT")
							get_node("/root/Game/farm_scene/SoilManager/soil"+str(number+39)).adjusted=true
					tilled=true
					
		else:
			Global.soil_clicked=false
			
		if event is InputEventMouseMotion:
			
			if Global.soil_clicked==true:
				animated_sprite_2d.play("tilled")
				tilled==true
		

			
