extends Button

func _ready() -> void:
	self.connect("pressed", Callable(self, "_on_button_down"))

func _on_button_down() -> void:
	print("BUYING")
	print("self.name :",self.name)
	print("PArent:",get_parent())
	get_node("/root/Game/SeedShopInterior/VendorMenu/seeds").seed_type=self.name
	get_node("/root/Game/SeedShopInterior/VendorMenu/seeds/Label").text=self.name
