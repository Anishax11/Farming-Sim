extends Area2D


class_name Soil
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var tilled=false
var adjusted=false
func _ready() -> void:
	if self.position==Vector2(-128,448):
		print("YESS")

#func _on_area_entered(area: Area2D) -> void:
	#
	#if !area is Soil: 
		#print(area.name)
		#queue_free()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed:
			
			
			var soil_pos=Vector2( int(position.x / 8) * 8,int(position.y / 8) * 8 )
			
			#print("Soil pos:",soil_pos)
			var player=get_node("/root/Game/Farmer")
			var player_pos=Vector2( int(player.position.x / 8) * 8,int(player.position.y / 8) * 8 )
			#print("Player pos:",player_pos)
			var distance=soil_pos.distance_to(player_pos)
			print(distance)
			if distance<=16:
				print(self.name)
				if Global.player_direction==Vector2(1,0):
					rotation_degrees=90
					player.get_node("AnimatedSprite2D").play("hoe_right")
				if Global.player_direction==Vector2(-1,0):
					rotation_degrees=-90
					
					player.get_node("AnimatedSprite2D").play("hoe_left")
					
				if Global.player_direction==Vector2(0,1):
					rotation_degrees=180
					player.get_node("AnimatedSprite2D").play("hoe_front")
				
				Global.soil_clicked=true
				if adjusted!=true:
					animated_sprite_2d.play("tilled")
				var text = self.name
				var regex = RegEx.new()
				regex.compile(r"\d+")  # Matches one or more digits
				var result = regex.search(text)

				if result:
					var number = int(result.get_string(0))
					if Global.player_direction==Vector2(1,0) and get_node("/root/Game/SoilManager/soil"+str(number-1)).adjusted!=true: 
						if get_node("/root/Game/SoilManager/soil"+str(number-1)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/SoilManager/soil"+str(number-1)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node("/root/Game/SoilManager/soil"+str(number-1)).get_node("AnimatedSprite2D").play("rect_tilled")
							get_node("/root/Game/SoilManager/soil"+str(number-1)).adjusted=true
							
					if Global.player_direction==Vector2(-1,0) and get_node("/root/Game/SoilManager/soil"+str(number+1)).adjusted!=true:
						if get_node("/root/Game/SoilManager/soil"+str(number+1)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/SoilManager/soil"+str(number+1)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node("/root/Game/SoilManager/soil"+str(number+1)).get_node("AnimatedSprite2D").play("rect_tilled")
							get_node("/root/Game/SoilManager/soil"+str(number+1)).adjusted=true
							
					if Global.player_direction==Vector2(0,1)  and get_node("/root/Game/SoilManager/soil"+str(number-39)).adjusted!=true:
						if get_node("/root/Game/SoilManager/soil"+str(number-39)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/SoilManager/soil"+str(number-39)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node("/root/Game/SoilManager/soil"+str(number-39)).get_node("AnimatedSprite2D").play("rect_tilled")
							get_node("/root/Game/SoilManager/soil"+str(number-39)).adjusted=true
					
					if Global.player_direction==Vector2(0,-1) and get_node("/root/Game/SoilManager/soil"+str(number+39)).adjusted!=true :
						
						if get_node("/root/Game/SoilManager/soil"+str(number+39)).tilled==true:
							print("Prev tilled")
							get_node("/root/Game/SoilManager/soil"+str(number+39)).get_node("AnimatedSprite2D").scale.y=0.21
							get_node("/root/Game/SoilManager/soil"+str(number+39)).get_node("AnimatedSprite2D").play("rect_tilled")
							get_node("/root/Game/SoilManager/soil"+str(number+39)).adjusted=true
					tilled=true
					
		else:
			Global.soil_clicked=false
			
		if event is InputEventMouseMotion:
			
			if Global.soil_clicked==true:
				animated_sprite_2d.play("tilled")
				tilled==true
