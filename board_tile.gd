class_name BoardTile
extends Resource

enum BoardTileType {
	EMPTY = -1,
	UNDEFINED = 0,
	BRICK_QUARRY = 1,
	FOREST = 2,
	PASTURE = 3,
	WHEAT_FIELD = 4,
	QUARRY = 5,
	DESERT = 6,
}

var type : BoardTileType
var number : int

func _init(_type : BoardTileType, _number : int = 0) -> void:
	type = _type
	number = _number
