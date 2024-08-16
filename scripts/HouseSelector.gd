extends Node2D

var house_positions = []
var houses = []

onready var camera = $Camera2D
onready var houses_node = $Houses
onready var tween = $Tween

var house_manager 

func _ready():
	for house in houses_node.get_children():
		house_positions.append(house.position)
		houses.append(house)
	
	house_manager = HouseManager.new(houses, house_positions, camera, tween)
	house_manager.update_camera_position()

class HouseManager:
	var houses
	var house_positions
	var camera
	var tween
	var current_index = 0

	func _init(houses, house_positions, camera, tween):
		self.houses = houses
		self.house_positions = house_positions
		self.camera = camera
		self.tween = tween

	func select_house(delta: int):
		current_index = clamp(current_index + delta, 0, houses.size() - 1)
		update_camera_position()
		
	func update_camera_position():
		tween.interpolate_property(camera, "position", camera.position, 
			house_positions[current_index], 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
		highlight_house()
		
	func highlight_house():
		for i in range(houses.size()):
			var house = houses[i]
			if i == current_index:
				house.modulate = Color(1, 1, 1, 1) # Яркий цвет для выделения
			else:
				house.modulate = Color(0.5, 0.5, 0.5, 1) # Тусклый цвет для остальных
