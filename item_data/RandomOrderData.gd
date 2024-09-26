extends OrderData
class_name RandomOrderData

export var order_size : int
export var order_possible_elements : Array

func generate_order():
	order.clear()
	for n in order_size:
		var rnd = randi() % order_possible_elements.size()
		order.push_back(order_possible_elements[rnd])
