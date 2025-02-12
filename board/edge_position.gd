class_name EdgePosition
extends Resource

# I will use the following assumptions:
# 1.	An 'edge position' is an edge of the game board
# 2.	An edge position is uniquely identified by a hex and
#		one of its three top sides

enum EdgeDir
{
	TOP_LEFT,
	TOP,
	TOP_RIGHT
}

var tile_position : TilePosition
var direction : EdgeDir

func _init(_tile_position : TilePosition = TilePosition.new(0, 0), _direction : EdgeDir = EdgeDir.TOP_LEFT):
	tile_position = _tile_position
	direction = _direction

func _hash() -> int:
	return hash([tile_position, direction])

func _eq(other : Variant) -> bool:
	if other.get_class() != self.get_class():
		return false
	return [tile_position, direction] == [other.tile_position, other.direction]
	
func get_neighbor_tiles() -> Array[TilePosition]:
	match direction:
		EdgeDir.TOP_LEFT:
			return [
				tile_position,
				tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_LEFT)
			]
		EdgeDir.TOP:
			return [
				tile_position,
				tile_position.get_neighbor(TilePosition.TileNeighbor.TOP)
			]
		EdgeDir.TOP_RIGHT:
			return [
				tile_position,
				tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_RIGHT)
			]
		_:
			return []
			
func get_endpoints() -> Array[VertexPosition]:
	match direction:
		EdgeDir.TOP_LEFT:
			return [
				VertexPosition.new(tile_position, VertexPosition.VertexDir.LEFT),
				VertexPosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_LEFT), VertexPosition.VertexDir.RIGHT)
			]
		EdgeDir.TOP:
			return [
				VertexPosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_LEFT), VertexPosition.VertexDir.RIGHT),
				VertexPosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_RIGHT), VertexPosition.VertexDir.LEFT)
			]
		EdgeDir.TOP_RIGHT:
			return [
				VertexPosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.TOP_RIGHT), VertexPosition.VertexDir.LEFT),
				VertexPosition.new(tile_position, VertexPosition.VertexDir.RIGHT)
			]
		_:
			return []
