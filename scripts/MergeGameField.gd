extends Control

onready var game_slots = $"%GridContainer"
var holding_item  = null

var mouse_left_down: bool = false

func _ready():
	GridObserver.connect("send_item",self,"instantiate_item_on_empty_slot")
	load_field_json()

func save_field_json():
	var slot_list: Dictionary = {}
#	print(game_slots.get_children())
	for game_slot in game_slots.get_children():
		var slot_item_data = game_slot.get_item_data()
		if  slot_item_data != null:
#			print(game_slot.get_child(0).item_data.name)
			slot_list[game_slot.name] = slot_item_data
#	print("---------------------------------")
	var save_path := "user://test_file.json"
	var json_string := JSON.print(slot_list)
	
	#saving file
	var file := File.new()
	file.open(save_path,File.WRITE)
	file.store_string(json_string)
	file.close()

func save_template_json():
	var slot_list: Dictionary = {} 
	
	var save_path := "user://test_file.json"
	var json_string := JSON.print({"Slot 13":{"res://items/generator_wood_pencilpack.tres":1}})
	
	#saving file
	var file := File.new()
	file.open(save_path,File.WRITE)
	file.store_string(json_string)
	file.close()

func load_field_json():
	var file := File.new()
	if !file.file_exists("user://test_file.json"):
		save_template_json()
	file.open("user://test_file.json", File.READ)
	var content = JSON.parse(file.get_as_text()).result
	file.close()
	for game_slot in game_slots.get_children():
		game_slot.reset()
	
	for game_slot in game_slots.get_children():
		if content.has(game_slot.name):
			if game_slot.item == null:
				game_slot.item = game_slot.ItemObject.instance()
				game_slot.add_child(game_slot.item)
			
			game_slot.item.tier = int(content[game_slot.name].values()[0])
			game_slot.item.item_data = load(content[game_slot.name].keys()[0])
			
			game_slot.refresh_item_tier()
		else:
			game_slot.item = null
			game_slot.refresh_item_tier()

func instantiate_item_on_empty_slot(item):
	var empty_slot_list = []
	for game_slot in game_slots.get_children():
		if game_slot.get_item_data() == null:
			empty_slot_list.push_back(game_slot)
	
	empty_slot_list[randi() % empty_slot_list.size()].instantiate_new_item(item)

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		save_field_json()
#		print("File Saved!")
	if Input.is_key_pressed(KEY_ENTER):
		load_field_json()


func _on_Button_pressed():
	get_tree().reload_current_scene()
