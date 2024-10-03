extends Node

signal send_item (item)
#signal check_order (item, tier)

var items_on_grid = []

func send_item_to_grid(item: Resource):
	emit_signal("send_item", item)

func send_item_to_observer(item_scene: Item):
	items_on_grid.push_back(item_scene)
	items_on_grid = make_array_unique(items_on_grid)

func remove_item_from_observer(item_scene: Item):
	items_on_grid.erase(item_scene)
	items_on_grid = make_array_unique(items_on_grid)

func check_order(order_scene: OrderList, order_data: OrderData):
	var temp_order_data = order_data.data.duplicate()
	var items_to_delete = []
	
	for item in items_on_grid:
		if temp_order_data.empty():
			break
#		if item == null:
#			items_on_grid.erase()
		
		for o in temp_order_data:
			if item.item_data == o.item_data && item.tier == o.tier:
				items_to_delete.push_back(item)
				temp_order_data.erase(o)
				break
	
	if temp_order_data.empty():
		print("Empty, deleting everything")
		for item in items_to_delete:
			items_on_grid.erase(item)
			item.reset(item.get_parent())
		order_scene.complete_order()
	else:
		print("Unlucky :(")

func make_array_unique(array: Array) -> Array:
	var unique: Array = []
	
	for item in array:
		if item != null && not unique.has(item):
			unique.append(item)
	
	return unique

func reload_level() -> void:
	items_on_grid.clear()
