extends Reference
class_name OrderData

export var data : Array
export var coins_amount : int
export var reward_data : Array

func generate(datapack : OrderDataPack):
	data.clear()
	reward_data.clear()
	
	coins_amount = 0
	
	if datapack.count <= 0:
		data = datapack.possible_elements.duplicate()
	else:
		for n in datapack.count:
			var rnd = randi() % datapack.possible_elements.size()
			data.push_back(datapack.possible_elements[rnd])
	
	if datapack.coins_amount > 0:
		coins_amount = datapack.coins_amount
	
	if datapack.has_reward:
		if datapack.reward_count <= 0:
			reward_data = datapack.possible_rewards.duplicate()
			return
		for n in datapack.reward_count:
			var rnd = randi() % datapack.possible_rewards.size()
			reward_data.push_back(datapack.possible_rewards[rnd])
