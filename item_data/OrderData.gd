extends Reference
class_name OrderData

export var data : Array


func generate(datapack : OrderDataPack):
	data.clear()
	if datapack.count <= 0:
		data = datapack.possible_elements.duplicate()
		return
	for n in datapack.count:
		var rnd = randi() % datapack.possible_elements.size()
		data.push_back(datapack.possible_elements[rnd])

