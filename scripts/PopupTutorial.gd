extends Control

onready var popup = $PopupBG

func _ready():
	var tween := create_tween()
	tween.tween_property(popup, "rect_scale", Vector2(1,1), 0.4)
	tween.tween_property(popup, "rect_pivot_offset", Vector2(0,0), 0.4)


func _on_Button_pressed():
	queue_free()
