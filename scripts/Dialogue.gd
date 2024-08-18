extends Control

signal dialog_completed

var dialog_lines = []
var current_line = 0

onready var dialog_label = $Text
onready var next_button = $NextButton

func start_dialog(lines):
	dialog_lines = lines
	current_line = 0
	dialog_label.text = dialog_lines[current_line]
	visible = true

func _on_NextButton_pressed():
	current_line += 1
	if current_line < dialog_lines.size():
		dialog_label.text = dialog_lines[current_line]
	else:
		visible = false
		emit_signal("dialog_completed")
