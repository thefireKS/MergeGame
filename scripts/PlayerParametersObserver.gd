extends Node

signal coins_updated (amount)

var coins : int setget set_coins

func set_coins(new_value):
	coins = new_value
	emit_signal("coins_updated", new_value)
