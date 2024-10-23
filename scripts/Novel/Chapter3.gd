extends Control

onready var gf = $F13/GameField as MergeField
onready var coins_amount = $F13/CoinsAmount

var rare_order_completed : bool = false

func _ready():
	PlayerParametersObserver.connect("coins_updated",self,"update_coins_text")
	$F13/OrderListSmall1.connect("order_completed",self,"_on_order_complete")
	$F13/OrderListSmall2.connect("order_completed",self,"_on_order_complete")
	$F13/OrderListSmall3.connect("order_completed",self,"_on_order_complete")
 
func _on_NextButtonF1_pressed():
	$F2.visible = true
	$F1.visible = false

func _on_NextButtonF2_pressed():
	$F3.visible = true
	$F2.visible = false

func _on_NextButtonF3_pressed():
	$F4.visible = true
	$F3.visible = false

func _on_NextButtonF4_pressed():
	$F5.visible = true
	$F4.visible = false

func _on_SkipButtonF1F2F3F4_pressed():
	$F5.visible = true
	$F4.visible = false
	$F3.visible = false
	$F2.visible = false
	$F1.visible = false

func _on_NextButtonF5_pressed():
	$F6.visible = true
	$F5.visible = false

func _on_BuyButtonF6_pressed():
	$F7.visible = true
	$F6.visible = false

func _on_NextButtonF7_pressed():
	$F8.visible = true
	$F7.visible = false

func _on_SkipButtonF7_pressed():
	$F8.visible = true
	$F7.visible = false

func _on_NextButtonF8_pressed():
	$F9.visible = true
	$F8.visible = false

func _on_NextButtonF9_pressed():
	$F9/NextButton.disabled = true
	$AnimationPlayer.play("CarRoom_Move")

func _on_F9_animation_end():
	$F10.visible = true
	$F9.visible = false

func _on_TextureButtonF10_pressed():
	$F11.visible = true
	$F10.visible = false

func _on_TextureButtonF11_pressed():
	$F12.visible = true
	$F11.visible = false

func _on_TextureButtonF12_pressed():
	$F13.visible = true
	gf.load_custom_field({"Slot 13":{"res://items/generator_wood_pencilpack.tres":1}})
	$F12.visible = false

func update_coins_text(value):
	coins_amount.text = str(value)

func _on_order_complete(order_type):
	if order_type == "rare":
		rare_order_completed = true
	else:
		if rare_order_completed == true && PlayerParametersObserver.coins >= 300:
			rare_three_hundred_completed()

func rare_three_hundred_completed():
	$F13.visible = false
	$F14.visible = true

func _on_NextButtonF14_pressed():
	$F14.visible = false
	$F15.visible = true

func _on_NextButtonF15_pressed():
	$AnimationPlayer.play("Car_Move")

func _on_F15_animation_end():
	$F15.visible = false
	$F16.visible = true

func _on_NextButtonF16_pressed():
	$F16.visible = false
	$F17.visible = true
