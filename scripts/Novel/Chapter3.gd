extends Control

onready var gf = $F13/GameField as MergeField
onready var coins_amount = $F13/CoinsAmount

var rare_order_completed : bool = false

var debug_skip_merge = false

func _ready():
	GridObserver.reload_level()
	PlayerParametersObserver.coins = 0
	$AnimationPlayer.play("RESET")
	
	PlayerParametersObserver.connect("coins_updated",self,"update_coins_text")
	$F13/OrderListSmall1.connect("order_completed",self,"_on_order_complete")
	$F13/OrderListSmall2.connect("order_completed",self,"_on_order_complete")
	$F13/OrderListSmall3.connect("order_completed",self,"_on_order_complete")
 
func _on_F1_visibility_changed():
	if $F1.is_visible_in_tree():
		$RobotSound.play()

func _on_NextButtonF1_pressed():
	$F2.visible = true
	HudConnector.Frame(3,2)
	$RobotSound.stop()
	$F1.visible = false

func _on_NextButtonF2_pressed():
	$F3.visible = true
	HudConnector.Frame(3,3)
	$RobotSound.play()
	$F2.visible = false

func _on_NextButtonF3_pressed():
	$F4.visible = true
	HudConnector.Frame(3,4)
	$RobotSound.stop()
	$F3.visible = false

func _on_NextButtonF4_pressed():
	$F5.visible = true
	HudConnector.Frame(3,5)
	$F4.visible = false

func _on_SkipButtonF1F2F3F4_pressed():
	$F5.visible = true
	HudConnector.Frame(3,5)
	$RobotSound.stop()
	$F4.visible = false
	$F3.visible = false
	$F2.visible = false
	$F1.visible = false

func _on_NextButtonF5_pressed():
	$F6.visible = true
	HudConnector.Frame(3,6)
	$F5.visible = false

func _on_BuyButtonF6_pressed():
	$F7.visible = true
	HudConnector.Frame(3,7)
	$RobotSound.play()
	$F6.visible = false

func _on_NextButtonF7_pressed():
	$F8.visible = true
	HudConnector.Frame(3,8)
	$RobotSound.stop()
	$F7.visible = false

func _on_SkipButtonF7_pressed():
	$F8.visible = true
	HudConnector.Frame(3,8)
	$RobotSound.stop()
	$F7.visible = false

func _on_NextButtonF8_pressed():
	$F9.visible = true
	HudConnector.Frame(3,9)
	$F8.visible = false

func _on_NextButtonF9_pressed():
	$F9/NextButton.disabled = true
	$AnimationPlayer.play("CarRoom_Move")

func _on_F9_animation_end():
	$F10.visible = true
	HudConnector.Frame(3,10)
	$F9.visible = false

func _on_TextureButtonF10_pressed():
	$F11.visible = true
	HudConnector.Frame(3,11)
	$F10.visible = false

func _on_TextureButtonF11_pressed():
	$F12.visible = true
	HudConnector.Frame(3,12)
	$F11.visible = false

func _on_TextureButtonF12_pressed():
	$F13.visible = true
	HudConnector.Frame(3,13)
	gf.load_custom_field({"Slot 13":{"res://items/generator_wood_pencilpack.tres":1}})
	$F12.visible = false

func update_coins_text(value):
	coins_amount.text = str(value)

func _on_order_complete(order_type):
	if order_type == "rare":
		rare_order_completed = true
	else:
		if rare_order_completed == true && PlayerParametersObserver.coins >= 300 || debug_skip_merge:
			rare_three_hundred_completed()

func rare_three_hundred_completed():
	$F13.visible = false
	$F14.visible = true
	HudConnector.Frame(3,14)

func _on_NextButtonF14_pressed():
	$F14.visible = false
	$F15.visible = true
	HudConnector.Frame(3,15)

func _on_NextButtonF15_pressed():
	$AnimationPlayer.play("Car_Move")

func _on_F15_animation_end():
	$F15.visible = false
	$RobotSound.play()
	$F16.visible = true
	HudConnector.Frame(3,16)

func _on_NextButtonF16_pressed():
	$F16.visible = false
	$RobotSound.stop()
	$F17/AudioStreamPlayer.play()
	$F17.visible = true
	HudConnector.Frame(3,17)


func _input(event):
	if event.is_action_pressed("Skip merge"):
		debug_skip_merge = true
