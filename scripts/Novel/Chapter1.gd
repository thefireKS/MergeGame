extends Control

#F1 button
func _on_StartButton_pressed():
	$F2.visible = true
	$F1.visible = false

#F2&F3 SKIP button
func _on_SkipButton_pressed():
	$F4.visible = true
	$F3.visible = false
	$F2.visible = false

#F2 NEXT button
func _on_NextButton_pressed():
	$F3.visible = true
	$F2.visible = false

#F3 NEXT button
func _on_NextButtonF3_pressed():
	$F4.visible = true
	$F3.visible = false

#F4 NEXT button
func _on_NextButtonF4_pressed():
	$F5.visible = true
	$F4.visible = false

#F5 SKIP button
func _on_SkipButtonF5_pressed():
	$F6.visible = true
	$F5.visible = false

#F5 NEXT button
func _on_NextButtonF5_pressed():
	$F6.visible = true
	$F5.visible = false

#End button
func _on_EndButton_pressed():
	get_tree().change_scene("res://scenes/Chapter2.tscn")