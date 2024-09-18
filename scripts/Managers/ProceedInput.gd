extends Node2D

var next = 1
var previous = -1

onready var town_node = get_node("/root/Town")
onready var coins_node = get_node("/root/Town/CanvasLayer/Coins")

func _input(event):
	if event.is_action_pressed("ui_right"):
		town_node.house_manager.select_house(next)
	elif event.is_action_pressed("ui_left"):
		town_node.house_manager.select_house(previous)
	elif event.is_action_pressed("AddMoney"):
		coins_node.coins.add(100)
	elif event.is_action_pressed("SubtractMoney"):
		coins_node.coins.subtract(20)
	
func _on_LeftButton_pressed():
	town_node.house_manager.select_house(previous)

func _on_RightButton_pressed():
	town_node.house_manager.select_house(next)
	

