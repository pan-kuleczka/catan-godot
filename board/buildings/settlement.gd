class_name Settlement
extends VertexBuilding

func _init(_player_color : int) -> void:
	super(_player_color)

static func get_cost() -> Dictionary:
	return {
		GameResource.BRICK : 1,
		GameResource.LUMBER : 1,
		GameResource.GRAIN : 1,
		GameResource.WOOL : 1
	}
	
static func get_tile_triggered_resources_received_multiplier() -> int:
	return 1
	
static func get_node() -> Node2D:
	var texture : CompressedTexture2D = load("res://assets/buildings/circle.svg")
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = texture
	return sprite
