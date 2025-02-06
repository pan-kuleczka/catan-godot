class_name MapTile
extends Resource

enum MapTileType {
	EMPTY = -1,
	UNDEFINED = 0,
	BRICK_QUARRY = 1,
	FOREST = 2,
	PASTURE = 3,
	WHEAT_FIELD = 4,
	QUARRY = 5,
	DESERT = 6,
}

var type : MapTileType
var number : int

func _init(_type : MapTileType, _number : int = 0) -> void:
	type = _type
	number = _number
