extends Resource
class_name mergebale_item

export var tier : int = 1
export var name : String
export var tier1_sprite : Texture
export var tier2_sprite : Texture
export var tier3_sprite : Texture
export var tier4_sprite : Texture
export var tier5_sprite : Texture

func  get_sprite() -> Texture:
	match tier:
		1:
			return tier1_sprite
		2:
			return tier2_sprite
		3:
			return tier3_sprite
		4:
			return tier4_sprite
		5:
			return tier5_sprite
		_:
			return tier1_sprite

func updgrade_tier() -> bool:
	if tier < 5:
		tier += 1
		return true
	else:
		return false
