extends Application

var hud 
func _ready() -> void:
	hud = HUD.new()
	api('connect_to_hud_app', {
		'target_node' : self,
		'on_message' : 'on_message',
		'on_error' : 'on_error',
		'on_connected' : 'on_connected',
		'on_disconnected' : 'on_disconnected',
	})
class HUD extends Application:
	
	const BLYAT = 0
	const REGULAR = 1
	func _init():
		pass
	
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

	func Frame(frame: int):
		api('send_to_hud_app', {
			"type" : "frame",
			"frame": frame
		})
