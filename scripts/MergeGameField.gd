extends Control

onready var game_slots = $GridContainer
var holding_item  = null

var mouse_left_down: bool = false

func _ready():
#	for game_slot in game_slots.get_children():
#		game_slot.connect("gui_input", self, "slot_gui_input", [game_slot])
#		game_slot.connect("focus_exited", self, "slot_gui_input", [game_slot])
	pass

func save_field_json():
	var slot_list : String = " " 
	print(game_slots.get_children())
	for game_slot in game_slots.get_children():
		if game_slot.get_child_count() > 0:
			print(game_slot.get_child(0).item_data.name)
			var slot := {
				"slot_data":{
					"item_data": game_slot.item
	#				"name": game_slot.item.name,
	#				"sprite": "res://"
				}  
			}
			slot_list += str(slot)
	print("---------------------------------")
	var save_path := "res://test_file.json"
	var json_string := slot_list.json_escape()
	
	#saving file
	var file := File.new()
	file.open(save_path,File.WRITE)
	file.store_string(json_string)
	file.close()

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		save_field_json()
		print("File Saved!")
#	if mouse_left_down and holding_item != null:
#		holding_item.global_position = get_global_mouse_position()

#func slot_gui_input(event: InputEvent, slot: SlotClass):
#	var item = slot.get_slot_item()
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT && event.pressed:
#			if holding_item != null:
#				if !item: #Place holding item to slot
#					slot.put_to_slot(holding_item)
#					holding_item = null
#				else: #Swap holding item with item in slot
#					var temp_item = item
#					if temp_item.item.item_data.name == slot.get_slot_item().item_data.name && temp_item.item.item_data.tier == slot.get_slot_item().item_data.tier :
#						if temp_item.item.updgrade_tier():
#							temp_item.queue_free()
#					else:
#						slot.pick_from_slot()
#						temp_item.global_position = event.global_position
#						slot.put_to_slot(holding_item)
#						holding_item = temp_item
#			elif item:
#				holding_item = slot.get_slot_item() # Consistency rather than slot.item.
#				slot.pick_from_slot()
#				holding_item.global_position = get_global_mouse_position()
#
#func _input(event):
#	if holding_item:
#		holding_item.global_position = get_global_mouse_position()
#		
#	if event is InputEventMouseButton:
#		if event.button_index == 1 and event.is_pressed():
#			mouse_left_down = true
#		elif event.button_index == 1 and not event.is_pressed():
#			mouse_left_down = false
