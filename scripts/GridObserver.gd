extends Node

signal send_item (item)

func send_item_to_grid(item: Resource):
	emit_signal("send_item", item)
	
