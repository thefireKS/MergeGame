extends Node2D

onready var town_node = get_node("/root/Town")
onready var coins_node = get_node("/root/Town/CanvasLayer/Coins")
onready var hud_node = $"%HUD Connector"
onready var story_node = $"../../StoryManager"

var house_index = -1
var level = 1
var upgrade_cost = 100 
var hud
var current_index:int

func set_index(index):
	house_index = index

func _ready():
	set_process_input(true)
	
	print("House ready: ", self.name)

func _input(event):
	if event.is_action_pressed("interact"):
		if is_selected():
			on_interact()

func input_event(viewport, event, shape_idx):
	if is_selected():
		if event is InputEventScreenTouch and event.is_pressed():
			print("Screen touched on house: ", house_index)
			on_interact()
		elif event is InputEventMouseButton and event.is_pressed():
			print("Mouse button pressed on house: ", house_index)
			on_interact()

func is_selected():
	return house_index == town_node.house_manager.get_current_index()

func on_interact():
	hud = hud_node.hud
	print(house_index)
	if house_index == 1 && story_node.current_state == story_node.State.DIALOG_2:
		print("trying to change scene")
		get_tree().change_scene("res://scenes/MergeGameField.tscn")
	if coins_node.coins.get_coins() - upgrade_cost >= 0:
		coins_node.coins.subtract(upgrade_cost)
		level_up()
		hud.change_house_state(town_node.house_manager.get_current_index(), hud.BLYAT)
		inflate_cost(100)
	print("Interacted with house: ", self.name)

	#ужас нагрузка
	var story_manager = get_tree().root.get_node("Town/StoryManager")
	story_manager._on_house_selected(self.house_index)
	


func level_up():
	level += 1  
	print("House ", self.name, " upgraded to level ", level)

func inflate_cost(cost: int):
	 upgrade_cost+= cost
