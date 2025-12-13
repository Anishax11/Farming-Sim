extends Node
var keys_array: Array = []
var tasks={
	"Task1" ={
		"title" : "Buy Starter Seeds",
		"Desc" : "Purchase strawberry, pumpkin, and potato seeds from the shop.",
		"completed" : false,
		"acquired" : false
	},
	
	"Task2"={
		"title" : "Tassk_2",
		"Desc" : "Complete task 2",
		"completed" : false,
		"acquired" : false
	}
	
}
#TASK 1:
var seeds_bought := {
	"strawberry": false,
	"pumpkin": false,
	"potato": false,
	# later...
	# "corn": false,
	# "melon": false,
	# "wheat": false,
}
#func _ready() -> void:
	#
	#while(self==null):
		#await get_tree().process_frame
		#
	
			#print_all(self)  # Print the hierarchy from TaskManager
			#
			 #
#func print_all(node, indent := 0):
				#print(" ".repeat(indent), "- ", node.name)
				#for c in node.get_children():
					#print_all(c, indent + 2)
