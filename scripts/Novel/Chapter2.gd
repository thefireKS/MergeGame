extends Control

onready var gf = $GameField as MergeField

var fifth_was_completed : bool = false

func _ready():
	GridObserver.connect("item_was_merged",self,"F5_item_merged")

#F1 & F2 & F3 SKIP button
func _on_SkipButtonF1F2F3_pressed():
	$F4.visible = true
	$F1.visible = false
	$F2.visible = false
	$F3.visible = false

#F1 NEXT button
func _on_NextButtonF1_pressed():
	$F2.visible = true
	$F1.visible = false

#F2 NEXT button
func _on_NextButtonF2_pressed():
	$F3.visible = true
	$F2.visible = false

#F3 NEXT button
func _on_NextButtonF3_pressed():
	$F4.visible = true
	$F3.visible = false

#F4 NEXT button
func _on_NextButtonF4_pressed():
	gf.visible = true
	gf.load_custom_field({"Slot 8":{"res://items/wood.tres":1}, "Slot 12":{"res://items/wood.tres":1}})
	$F5.visible = true
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
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", self, "_on_timer_timeout")
	
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($GameField, "rect_position",
		Vector2(483, 79), Vector2(901, 79), 1.5,
		Tween.TRANS_LINEAR)
	tween.start()

func _on_timer_timeout():
	$F7.visible = true
	$F6.visible = false
