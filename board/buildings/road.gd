class_name Road
extends EdgeBuilding

func _init(_player_color : int) -> void:
	super(_player_color)

static func get_cost() -> Dictionary:
	return {
		GameResource.LUMBER : 1,
		GameResource.BRICK : 1
	}

func get_node() -> Node2D:
	var texture : CompressedTexture2D = load("res://assets/buildings/road.svg")
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = texture
	sprite.modulate = PlayerColor.get_rgb(player_color)
	return sprite
