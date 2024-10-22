extends TextureRect
class_name Item

export var item_data : Resource
export var particles : PackedScene
export var tier : int = 0

var timer
var last_event

func _ready():
	randomize()
	
	if item_data == null:
		return
	
#	GridObserver.send_item_to_observer(self)
	
	if item_data.is_generator:
		for child in get_children():
			if child.get_class() == "Timer":
				timer = child
				timer.connect("timeout",self,"finger_released")
#	if randi() % 2 == 0:
#		item_data = load("res://items/test_item_1.tres")#.duplicate()
##		item_data.set_meta("path", "res://items/test_item_1.tres")
#	else:
#		item_data = load("res://items/test_item_2.tres")#.duplicate()
##		item_data.set_meta("path", "res://items/test_item_2.tres")
#	var rng : int = randi() % 3
#	match rng:
#		0:
#			item_data = load("res://items/test_item_1.tres")#.duplicate()
#		1:
#			item_data = load("res://items/test_item_2.tres")#.duplicate()
#		2:
#			item_data = load("res://items/test_item_2.tres")
#
#	refresh()


func refresh():
	if item_data.is_generator && timer == null:
		timer = Timer.new()
		timer.name = "Timer"
		add_child(timer)
		timer.wait_time = 0.15
		timer.one_shot = true
		timer.connect("timeout",self,"finger_released")
		var generator_particles = particles.instance()
		add_child(generator_particles)
	
	texture = item_data.get_sprite(tier)
	
	GridObserver.send_item_to_observer(self)
#	$Label.text = str(tier)

func reset(parent_container) -> void:
	GridObserver.remove_item_from_observer(self)
	parent_container.clear()
	queue_free()

func upgrade_tier():
	if tier < item_data.sprites.size():
		tier += 1
		print("{item_name}'s tier increased to {tier}".format({"item_name": name, "tier": str(tier)}))
		refresh()


func get_data() -> Dictionary:
	var data_dict = {item_data.resource_path : tier}
	return data_dict


func _gui_input(event):
	if !(event is InputEventScreenTouch) or !item_data.is_generator:
		return
	last_event = event
	if last_event is InputEventScreenTouch:
#			print("InputEventScreenTouch")
			if last_event.pressed:
#				print("START TIMER")
				timer.start()

func finger_released():
#	print("TIMER TIMEOUT")
#		print("GENERATOR")
	if last_event is InputEventScreenTouch:
#		print("InputEventScreenTouch in finger released")
		if last_event.pressed == false:
			GridObserver.send_item_to_grid(item_data.items_to_generate[randi() % item_data.items_to_generate.size()])
			last_event = null
