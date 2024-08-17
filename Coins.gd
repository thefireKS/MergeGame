extends Node

onready var UICurrency = $CurrentNubmer

var coins

func _ready():
	coins = Coins.new(0, UICurrency)

class Coins:
	
	var amount: int
	var UICurrency
	
	func _init(amount, UICurrency):
		self.amount = amount
		self.UICurrency = UICurrency
		
	
	func add(amount_to_add: int):
		amount += amount_to_add
		updateUI(amount)

	func subtract(amount_to_subtract: int) -> void:
		if amount_to_subtract > amount:
			return
		amount -= amount_to_subtract
		updateUI(amount)

	func updateUI(amount: int):
		UICurrency.text = str(amount)
	
	func get_coins():
		return amount
