extends TextureRect

export var order_data : Resource
export var order_icon : PackedScene
onready var icons = $HBoxContainer

var listed_order_array = []

func _ready():
	for order in order_data.order:
		var ord_ico = order_icon.instance()
		icons.add_child(ord_ico)
		ord_ico.set_order_icon(order.get_sprite(order_data.order[order]))
		
		var list_ord = ListedOrder.new()
		list_ord.item_data = order
		list_ord.item_tier = order_data.order[order]
		list_ord.on_field = false
		
		listed_order_array.push_back(list_ord)
		
	GridObserver.connect("check_order",self,"update_order_state")

func update_order_state(item_res: Resource, tier: int):
	for order in listed_order_array:
		if order.item_data == item_res && order.item_tier == tier && !order.on_field:
			order.on_field = true
			check_for_complete()

func check_for_complete():
	var on_field_count = 0
	for order in listed_order_array:
		if order.on_field:
			on_field_count += 1
	if on_field_count == listed_order_array.size():
		print("YAYA")

class ListedOrder:
	export var item_data : Resource
	export var item_tier : int
	export var on_field : bool
