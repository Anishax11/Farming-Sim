extends ColorRect
var i=0
var color_array:Array=[
	"E6F0FF",   # 6 AM - Barely visible blue mist
	"B4DCFF",  # 8 AM - Sky Blue
	"FFFFFF",   # 12 PM - Daylight
	"C8F0FF",  # 2 PM - Clear Sky
	"FFE6BE",   # 4 PM - Afternoon Haze
	"FFC88C",   # 6 PM - Golden Hour
	"DC8CB4",   # 7 PM - Dusk Amber
	"7864B4",   # 8 PM - Twilight Violet
	"283C78",   # 9 PM - Nightfall Blue
	"141E32",   # 10 PM - Deep Night
	"0A0A14"]   # 12 AM - Midnight
		  


var opacity:Array=[0.1,0.05,0.0,0.03,0.1,0.2,0.3,0.4,0.5,0.6,0.8]

#func _ready() -> void:
	#adjust_tint()

func adjust_tint():
	if i!=null and i<11:
		color=Color(color_array[i])
		color.a=opacity[i]
		
		i+=1	
