extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var stage
#
#func _ready() -> void:
	#print("Plant scene called")
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player and animated_sprite_2d.animation!="stage_1" :
		#print("FARMER Y pos",body.position.y)
		#print("PLANT:",position.y)
		z_index=-1


func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		
		z_index=0

func grow_plant():
	var last_char = self.name.substr(self.name.length() - 1, 1)
	var index=int(last_char)-1
	stage=PlantTracker.plant_stages["Plant"+str(index)]
	print("GROWING")
	#print("PLANT STAGE:",stage)
	stage+=1
	#print("PLANT STAGE AFTER:",stage)
	if stage>3:
		print("Returning from grow plant")
		return
	else:
		self.scale.x=0.3
		self.scale.y=0.3
		animated_sprite_2d.play("stage_"+str(stage))
		print("PLant animation:",animated_sprite_2d.animation)
		PlantTracker.update_plant_dictionary("Plant"+str(index))
