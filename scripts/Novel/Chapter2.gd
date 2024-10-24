extends Control

export var quest_done_texture : Texture

onready var gf = $GameField as MergeField

var fifth_was_completed : bool = false
var F10_spawned_items_amount : int = 0

var merged_items_amount : int = 0 #25 to complete
var completed_orders_amount : int = 0 #10 to complete

func _ready():
	GridObserver.reload_level()
	
	GridObserver.connect("item_was_merged",self,"F5_item_merged")
	GridObserver.connect("item_was_merged",self,"_on_item_merge")
	
	GridObserver.connect("order_completed",self,"F7_order_completed")
	GridObserver.connect("order_completed",self,"_on_order_complete")
	
	GridObserver.connect("send_item", self, "F10_check_spawned_items_amount")

#F1 & F2 & F3 SKIP button
func _on_SkipButtonF1F2F3_pressed():
	$F4.visible = true
	$RobotSound.play()
	$F1.visible = false
	$F2.visible = false
	$F3.visible = false

func _on_F1_visibility_changed():
	if $F1.is_visible_in_tree():
		$RobotSound.play()

#F1 NEXT button
func _on_NextButtonF1_pressed():
	$F2.visible = true
	$RobotSound.stop()
	$F1.visible = false

#F2 NEXT button
func _on_NextButtonF2_pressed():
	$F3.visible = true
	$F2.visible = false

#F3 NEXT button
func _on_NextButtonF3_pressed():
	$F4.visible = true
	$RobotSound.play()
	$F3.visible = false

#F4 NEXT button
func _on_NextButtonF4_pressed():
	gf.visible = true
	gf.load_custom_field({"Slot 8":{"res://items/wood.tres":1}, "Slot 12":{"res://items/wood.tres":1}})
	$F5.visible = true
	$RobotSound.stop()
	$F4.visible = false

func F5_item_merged():
	if !fifth_was_completed && $F5.is_visible_in_tree():
		$F6.visible = true
		$F5.visible = false
		fifth_was_completed = true

func _on_F6_visibility_changed():
	if !$F6.is_visible_in_tree():
		return
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", self, "_on_F6_timer_timeout")
	
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($GameField, "rect_position",
		Vector2(483, 79), Vector2(901, 79), 1.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_F6_timer_timeout():
	$F7.visible = true
	$F6.visible = false

func F7_order_completed():
	if !$F7.is_visible_in_tree():
		return
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", self, "_on_F7_timer_timeout")

func _on_F7_timer_timeout():
	$F8.visible = true
	$RobotSound.play()
	gf.visible = false
	$F7.visible = false

func _on_NextButtonF8_pressed():
	$F9.visible = true
	$RobotSound.stop()
	$RobotSound.play()
	$F8.visible = false

func _on_NextButtonF9_pressed():
	$F10.visible = true
	gf.visible = true
	gf.rect_position = Vector2(483,79)
	gf.load_custom_field({"Slot 13":{"res://items/generator_wood_pencilpack.tres":1}})
	$RobotSound.stop()
	$F9.visible = false

func F10_check_spawned_items_amount(item: Resource):
	if !$F10.is_visible_in_tree():
		return
	F10_spawned_items_amount += 1
	if F10_spawned_items_amount >= 2:
		$F11.visible = true
		$F10.visible = false

func _on_QuestButtonF11_pressed():
	gf.rect_position = Vector2(901, 79)
	$FQuest.visible = true
	$F12.visible = true
	$F11.visible = false

func _on_QuestButtonF12_pressed():
	$FQuest.visible = true

func _on_EndButtonFQ_pressed():
	if merged_items_amount < 25 || completed_orders_amount < 10:
		$FQuest.visible = false
		return
	$F13.visible = true
	$F13/AudioStreamPlayer.play()
	$GameField.visible = false
	$FQuest.visible = false

func _on_item_merge():
	merged_items_amount += 1
	
	if merged_items_amount >= 25:
		$FQuest/QuestList/Quest1/HBoxContainer/QuestStatus.texture = quest_done_texture

func _on_order_complete():
	completed_orders_amount += 1
	
	if completed_orders_amount >= 10:
		$FQuest/QuestList/Quest2/HBoxContainer/QuestStatus.texture = quest_done_texture
		if merged_items_amount >= 25:
			$FQuest.visible = true

func _on_NextButtonF13_pressed():
	get_tree().change_scene("res://scenes/Chapter3.tscn")

