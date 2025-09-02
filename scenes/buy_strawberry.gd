extends Button


	


func _on_button_down() -> void:
	print("BUYING")
	
	get_node("/root/Game/SeedShopInterior/VendorMenu/seeds").seed_type="strawberry"
