extends Node

var main_theme

func _ready():
	main_theme = AudioStreamPlayer.new()
	add_child(main_theme)
	main_theme.stream = load("res://sfx/music_theme.wav")
	main_theme.volume_db = -25
	main_theme.play()
	print("should play")
