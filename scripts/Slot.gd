extends Panel
class_name SlotClass

export var ItemObject: PackedScene
export var ItemDragPreview: PackedScene

var FilledStyle : StyleBoxTexture = preload("res://styles/MergeGameFieldFilledStyle.tres")
var EmptyStyle : StyleBoxTexture = preload("res://styles/MergeGameFieldEmptyStyle.tres") 

var item: Item = null


func _ready():
	pass
#	randomize()
#	if randi() % 2 == 0 :
#		item = ItemObject.instance()
#		add_child(item)
#	refresh_style()
	
#	print(item.item_data)

func refresh_style():
	if item == null:
		set('custom_styles/panel', EmptyStyle)
	else:
		set('custom_styles/panel', FilledStyle)

func refresh_item_tier():
	if item != null:
		item.refresh()
	refresh_style()

# When you drag from one slot to another, this gets called. 
# This is where we add our preview too
# Godot provides this.
func get_drag_data(position: Vector2):
	var data = {}
	
	data["item"] = item
	
	# Set Drag Preview
	if item != null:
		var preview: TextureRect = ItemDragPreview.instance()
		preview.texture = item.texture
		set_drag_preview(preview)

	return data

# This is a conditional function that tells UI elements if they can drop based on conditions
# For now, we check against if item in data dictionary is not null
# Godot provides this.
func can_drop_data(position: Vector2, data) -> bool:
	if data["item"] != null:
		return true
	return false

# This is actual logic of swapping of slots and where to put all logics. You can
# call functions here or manipulate whatever you like
# Godot provides this.
func drop_data(position: Vector2, data) -> void:
	var dropped_item: Item = data["item"]
	var dropped_item_parent: SlotClass = dropped_item.get_parent() # The Slot
	# If dropped slot is same as current, don't do anything
	if dropped_item_parent == self:
		return
	
	# Check if item is null or not, if it's not null then
	if item != null:
		# We check if both items are equal, if it's same then
		if dropped_item.item_data.name == item.item_data.name && dropped_item.tier == item.tier && dropped_item.tier < dropped_item.item_data.sprites.size():
			# Upgrade the tier
			item.upgrade_tier()
			# Remove the child from the the slot it dropped on this one and reset it.
			dropped_item.reset(dropped_item_parent)
		# If it's not same, swap it or place it.
		else:
			# Remove the current slot's item
			var swap_drop_item = dropped_item.duplicate()
			var swap_inner_item = item.duplicate()
			
			item.reset(self)
			print("reset item itself")
			dropped_item.reset(dropped_item_parent)
			print("reset other item")
			# Remove the dropped slot's item
			# Add the current slot's item that we removed on line 55
			dropped_item_parent.item = swap_inner_item
			dropped_item_parent.add_child(swap_inner_item)
			dropped_item_parent.refresh_item_tier()
			print("added other item copy")
			# Set the dropped slot to current slot's item
			
			# Add the dropped slot's item to current slot
			item = swap_drop_item
			add_child(swap_drop_item)
			refresh_item_tier()
			print("added item copy")
			# Set the current slot to dropped slot's item
	# If current slot's item is null, then
	else:
		# Reset dropped slot's item and remove it.
		# Add the dropped slot's removed item to current slot
		var fresh_item = dropped_item.duplicate()
		add_child(fresh_item)
		# Set it
		item = fresh_item
		
		dropped_item.reset(dropped_item_parent)
	
	# Refresh the styles
	dropped_item_parent.refresh_style()
	refresh_style()
	
	# Refresh the tier
	dropped_item_parent.refresh_item_tier()
	refresh_item_tier()

func get_item_data():
	if item == null:
		return null
	else:
		return item.get_data()

func instantiate_new_item(data):
	item = ItemObject.instance()
	add_child(item)
	item.item_data = data
	item.refresh()
	refresh_style()

func clear():
#	print(self.name + " Clear got called")
	if item != null:
		item = null
	refresh_style()


