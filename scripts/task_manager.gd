extends Node

var tasks={
	"Task1" ={
		"title" : "Tassk_1",
		"Desc" : "Complete task 1",
		"completed" : false,
		"acquired" : true
	},
	
	"Task2"={
		"title" : "Tassk_2",
		"Desc" : "Complete task 2",
		"completed" : false,
		"acquired" : true
	}
	
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
