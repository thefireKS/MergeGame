extends TextureRect
class_name Item

export var item_data : Resource

func _ready():
	if randi() % 2 == 0:
		item_data = load("res://items/test_item_1.tres")
	else:
		item_data = load("res://items/test_item_2.tres")
	item_data.resource_local_to_scene = true
	
	texture = item_data.get_sprite()
	refresh()

func refresh():
	$Label.text = str(item_data.tier)
