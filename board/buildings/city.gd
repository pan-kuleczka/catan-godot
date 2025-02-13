class_name City
extends VertexBuilding

func _init(_player_color : int) -> void:
	super(_player_color)

static func get_cost() -> Dictionary:
	return {
		GameResource.ORE : 3,
		GameResource.GRAIN : 2
	}

static func get_prerequisite_building() -> Type:
	return Type.get_type(Settlement)

func get_node() -> Node2D:
	var texture : CompressedTexture2D = load("res://assets/buildings/city.svg")
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = texture
	sprite.modulate = PlayerColor.get_rgb(player_color)
	return sprite

static func get_tile_triggered_resources_received_multiplier() -> int:
	return 2
