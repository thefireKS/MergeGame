extends TextureRect
class_name Item

export var item_data : Resource
export var tier : int = 0

func _ready():
	if randi() % 2 == 0:
		item_data = load("res://items/test_item_1.tres")#.duplicate()
#		item_data.set_meta("path", "res://items/test_item_1.tres")
	else:
		item_data = load("res://items/test_item_2.tres")#.duplicate()
#		item_data.set_meta("path", "res://items/test_item_2.tres")
	
	refresh()


func refresh():
	texture = item_data.get_sprite(tier)
#	$Label.text = str(tier)


func upgrade_tier():
	if tier < 5:
		tier += 1
		print("{item_name}'s tier increased to {tier}".format({"item_name": name, "tier": str(tier)}))
		refresh()


func get_data() -> Dictionary:
	var data_dict = {item_data.resource_path : tier}
	return data_dict
