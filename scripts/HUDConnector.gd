extends Application

func _ready() -> void:
	api('connect_to_hud_app', {
		'target_node' : self,
		'on_message' : 'on_message',
		'on_error' : 'on_error',
		'on_connected' : 'on_connected',
		'on_disconnected' : 'on_disconnected',
	})

func move_town(distance:int):
	api('send_to_hud_app', {
			"type" : "move",
			"distance": distance})
			
func change_house_state(houseIndex:int, state:int):
	api('send_to_hud_app', {
			"type" : "sprite",
			"index": houseIndex,
			"state": state})
			
func active_house(houseIndex:int):
	api('send_to_hud_app', {
			"type" : "active",
			"index": houseIndex
			})

func Frame(chapter: int,frame: int):
	print("pls change to chapter ", chapter,"to frame ", frame)
	api('send_to_hud_app', {
		"type" : "frame",
		"chapter": chapter,
		"frame": frame
	})

func on_disconnected():
	print("[Event]: Disconnected\n")


func on_error(error_text: String):
	print("[Error]: " + error_text + "\n")
