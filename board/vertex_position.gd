class_name VertexPosition
extends Resource

# This is a very tricky class to implement. I will use the following assumptions:
# 1.	A 'vertex position' is a vertex of the game board
# 2.	A vertex position is uniquely identified by a hex and either its
#		left or right vertex

enum VertexDir
{
	LEFT,
	RIGHT
}

var tile_position : TilePosition
var direction : VertexDir

func _init(_tile_position : TilePosition = TilePosition.new(0, 0), _direction : VertexDir = VertexDir.LEFT):
	tile_position = _tile_position
	direction = _direction

func get_neighbor_tiles() -> Array[TilePosition]:
	match direction:
		VertexDir.LEFT:
			return [
				tile_position,
				tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_LEFT),
				tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_LEFT)
			]
		VertexDir.RIGHT:
			return [
				tile_position,
				tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_RIGHT),
				tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_RIGHT)
			]
		_:
			return []
