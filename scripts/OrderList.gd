extends Control
class_name OrderList

export var order_datapack : Resource
export var order_icon : PackedScene
#onready var slots_grid = $"%GridContainer"
onready var icons = $OrderItems

var order : OrderData
#var listed_order_array = []

func _ready():
	randomize()
	read_order_data()

func read_order_data():
	order = OrderData.new()
	order.generate(order_datapack)
	for order_element in order.data:
		var ord_ico = order_icon.instance()
		icons.add_child(ord_ico)
		ord_ico.set_order_icon(order_element.item_data.get_sprite(order_element.tier))
	set_order_list_size()

func set_order_list_size():
	var numberof_items = order.data.size()
	match numberof_items:
		1:
			rect_size.x = 715
		2:
			rect_size.x = 904
		3:
			rect_size.x = 1032
		_:
			rect_size.x = 715
	print(rect_size.x)
#func update_order_state(item_res: Resource, tier: int, scene: Item):
#	for order in listed_order_array:
#		if order.item_scene != scene:
#			if order.item_data == item_res && order.item_tier == tier && !order.on_field:
#				order.on_field = true
#				order.item_scene = scene
#				print(str(order) + "now on field")
#				break

#func check_for_complete() -> bool:
#	var on_field_count = 0
#	for order in listed_order_array:
#		if order.item_scene != null:
#			if order.on_field && order.item_tier == order.item_scene.tier:
#				on_field_count += 1
#		else:
#			order.on_field = false
#
#
#	if on_field_count == listed_order_array.size():
#		return true
#	else:
#		return false

func complete_order():
	print("YAY SOLD")
#	if !check_for_complete():
#		return
#
#	for order in listed_order_array:
#		print(str(order.item_data) + " " + str(order.item_scene) + "got reset")
#		order.item_scene.reset()
#		order.item_scene = null
#		order.on_field = false

#	refresh_grid_slots()

#func refresh_grid_slots():
#	for slot in slots_grid.get_children():
#		slot.refresh_item_tier()

func _on_Button_pressed():
	GridObserver.check_order(self,order)

#class ListedOrderElement:
#	export var item_data : Resource
#	export var item_tier : int
#	export var on_field : bool
#	var item_scene : Item
