extends Node2D

var house_positions = []
var houses = []

onready var camera = $Camera2D
onready var houses_node = $Houses
onready var tween = $Tween
onready var hud_node = $"%HUD Connector"

var house_manager 

func _ready():
	for i in range(houses_node.get_child_count()):
		var house = houses_node.get_child(i)
		house_positions.append(house.position)
		houses.append(house)
		house.set_index(i)
	
	house_manager = HouseManager.new(houses, house_positions, camera, tween, hud_node)
	house_manager.update_camera_position()

class HouseManager:
	var houses
	var house_positions
	var camera
	var tween
	var current_index = 0
	var camera_last_position
	var hud

	func get_camera_pos() -> float:
		return camera.position.x
		
	func _init(houses, house_positions, camera, tween, hud_node):
		self.houses = houses
		self.house_positions = house_positions
		self.camera = camera
		self.tween = tween
		self.camera_last_position = get_camera_pos()
		self.hud = hud_node.hud

	func select_house(delta: int):
		current_index = clamp(current_index + delta, 0, houses.size() - 1)
		update_camera_position()
		camera_last_position = get_camera_pos()
		var distance:int = int(camera_last_position) - int(house_positions[current_index].x)
		print(camera_last_position, "  ", house_positions[current_index].x," fsdp;kjfads ",distance)
		hud.move_town(distance)
		hud.active_house(current_index)
		hud.change_house_state(current_index, hud.REGULAR)
		
	func update_camera_position():
		tween.interpolate_property(camera, "position", camera.position, 
			house_positions[current_index], 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
		highlight_house()
		
	func highlight_house():
		for i in range(houses.size()):
			var house = houses[i]
			if i == current_index:
				house.modulate = Color(1, 1, 1, 1)
			else:
				house.modulate = Color(0.5, 0.5, 0.5, 1)
				
	func get_current_index():
		return current_index
