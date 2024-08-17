extends ColorRect

export var order_data : Resource
export var order_icon : PackedScene
onready var slots_grid = $"%GridContainer"
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

func update_order_state(item_res: Resource, tier: int, scene: Item):
	for order in listed_order_array:
		if order.item_data == item_res && order.item_tier == tier && !order.on_field:
			order.on_field = true
			order.item_scene = scene

func check_for_complete() -> bool:
	var on_field_count = 0
	for order in listed_order_array:
		if !order.item_scene == null:
			if order.item_tier != order.item_scene.tier:
				order.on_field = false
				order.item_scene = null
			if order.on_field && order.item_tier != order.item_scene.tier:
				order.on_field = false
				order.item_scene = null
			if order.on_field && order.item_tier == order.item_scene.tier:
				on_field_count += 1
		else:
			order.on_field = false
		
		print(str(order.item_scene) + " " + str(order.on_field))
	
	if on_field_count == listed_order_array.size():
		return true
	else:
		return false

func complete_order():
	if !check_for_complete():
		return
	
	for order in listed_order_array:
		print(str(order.item_data) + " " + str(order.item_scene))
		order.item_scene.get_parent().reset()
		order.item_scene = null
		order.on_field = false
	
	refresh_grid_slots()

func refresh_grid_slots():
	for slot in slots_grid.get_children():
		slot.refresh_item_tier()

func _on_Button_pressed():
	complete_order()

class ListedOrder:
	export var item_data : Resource
	export var item_tier : int
	export var on_field : bool
	var item_scene : Item
