extends Node

enum State { DIALOG_1, SELECT_HOUSE, DIALOG_2, TASK_COMPLETION }

var current_state = State.DIALOG_1
var dialog_scene
var hud

onready var hud_node = $"%HUD Connector"
onready var canvas = $"../CanvasLayer"

func _ready():
	hud = hud_node.hud
	get_scene_ready()
	dialog_scene.connect("dialog_completed", self, "_on_dialog_completed")
	start_dialog_1()


func start_dialog_1():
	current_state = State.DIALOG_1
	dialog_scene.start_dialog([
		"Пппривет, земляне! Шутка. \n"+
		"Я твой робопомощник, хотя, наверное, телепомощник или телеробопомощник",
		
		"Теперь о насущном, наш городок называется Атомск и здесь нас ждут великие дела."+
		"То есть, тебя, ждут великие дела, но всегда приятно себя причислить к тому,"+
		"к чему руку не прикладывал",
		
		"Мы должны поднять нашу автомобильную промышленность. Для этого необходимо восстановить сборочную линию\n",
		"Выбери стрелочками завод и нажми E"
	])

func start_house_selection():
	current_state = State.SELECT_HOUSE
	# Логика для активации выбора дома
	print("Выберите домик для улучшения.")
	

func start_dialog_2():
	get_scene_ready()
	current_state = State.DIALOG_2
	dialog_scene.start_dialog([
		"Не верю, не верю... что вы так быстро управились. \n"+
		"Мне казалось, что это просто невозможно."+
		"Ладно, на самом деле это лишь начало нашего пути.",
		
		"Теперь можешь перейти к игре Merge - снова нажми E на завод"
	])

func _on_dialog_completed():
	match current_state:
		State.DIALOG_1:
			dialog_scene.queue_free()
			dialog_scene = null
			start_house_selection()
		State.DIALOG_2:
			dialog_scene.queue_free()
			dialog_scene = null

func _on_house_selected(house_index):
	if current_state == State.SELECT_HOUSE:
		if house_index == 1:
			print("Выбран второй дом:")
			hud.change_house_state(1, hud.REGULAR)
			start_dialog_2()
			

func get_scene_ready():
	if dialog_scene == null:
		dialog_scene = preload("res://scenes/Dialogue.tscn").instance()
		canvas.add_child(dialog_scene)
