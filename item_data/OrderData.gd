extends Reference
class_name OrderData

export var order : Array

func generate(data : OrderDataPack):
	order.clear()
	if data.count <= 0:
		order = data.possible_elements.duplicate()
		return
	for n in data.count:
		var rnd = randi() % data.possible_elements.size()
		order.push_back(data.possible_elements[rnd])

