extends Reference
class_name OrderObject

var data: Resource
var tier: int
export var load_data: Resource

func init(order_data: Resource) -> void:
	data = order_data.data
	tier = order_data.tier
