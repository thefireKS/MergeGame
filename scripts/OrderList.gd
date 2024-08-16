extends TextureRect

export var order_data : Resource
export var order_icon : PackedScene
onready var icons = $HBoxContainer

var index : int

func _ready():
	for o in order_data.order:
		var oi = order_icon.instance()
		icons.add_child(oi)
		oi.set_order_icon(o.get_sprite(order_data.order[o]))
		index += 1
