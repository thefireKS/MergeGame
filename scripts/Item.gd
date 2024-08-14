extends Node2D
class_name Item

export var item_data : Resource
onready var texture = $TextureRect

func _ready():
	if randi() % 2 == 0:
		item_data = load("res://items/test_item_1.tres")
	else:
		item_data = load("res://items/test_item_2.tres")
	item_data.resource_local_to_scene = true
	
	texture.texture = item_data.get_sprite()
