extends Resource
class_name OrderDataPack

export var count : int
export var possible_elements : Array

export var coins_amount : int

export var has_reward : bool
export var reward_count : int
export var possible_rewards : Array
#func give_random_item() -> Resource:
#	var rnd = randi() % order_possible_elements.size()
#	return order_possible_elements[rnd]
