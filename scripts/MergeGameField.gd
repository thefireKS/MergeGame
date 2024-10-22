extends Control

onready var gf = $GameField as MergeField

func _ready():
	gf.load_field_json()

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		gf.save_field_json()
#		print("File Saved!")
	if Input.is_key_pressed(KEY_ENTER):
		gf.load_field_json()

func _on_Button_pressed():
	GridObserver.reload_level()
	get_tree().reload_current_scene()
