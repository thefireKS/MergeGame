extends Node

signal send_item (item)
signal check_order (item, tier)

func send_item_to_grid(item: Resource):
	emit_signal("send_item", item)

func send_item_to_order(item: Resource, tier: int, item_scene: Item):
	emit_signal("check_order", item, tier, item_scene)
