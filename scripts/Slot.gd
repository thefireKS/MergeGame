extends Panel

var FilledStyle : StyleBoxTexture = preload("res://styles/MergeGameFieldFilledStyle.tres")
var EmptyStyle : StyleBoxTexture = preload("res://styles/MergeGameFieldEmptyStyle.tres") 

var ItemClass = preload("res://scenes/Item.tscn")
var item = null

func _ready():
	if randi() % 2 == 0 :
		item = ItemClass.instance()
		add_child(item)
	refresh_style()

func refresh_style():
	if item == null:
		set('custom_styles/panel', EmptyStyle)
	else:
		set('custom_styles/panel', FilledStyle)

func pick_from_slot():
	remove_child(item)
	var inventoryNode = find_parent("MergeGameField")
	inventoryNode.add_child(item)
	item = null
	refresh_style()

func put_to_slot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("MergeGameField")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()

func get_slot_item() -> Item:
	return item
