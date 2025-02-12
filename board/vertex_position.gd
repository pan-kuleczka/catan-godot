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

func _hash() -> int:
	return hash([tile_position, direction])

func _eq(other : Variant) -> bool:
	if other.get_class() != self.get_class():
		return false
	return [tile_position, direction] == [other.tile_position, other.direction]
	
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
			
func get_neighbor_edges() -> Array[EdgePosition]:
	match direction:
		VertexDir.LEFT:
			return [
				EdgePosition.new(tile_position, EdgePosition.EdgeDir.TOP_LEFT),
				EdgePosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_LEFT), EdgePosition.EdgeDir.TOP_RIGHT),
				EdgePosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_LEFT), EdgePosition.EdgeDir.TOP)
			]
		VertexDir.RIGHT:
			return [
				EdgePosition.new(tile_position, EdgePosition.EdgeDir.TOP_RIGHT),
				EdgePosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_RIGHT), EdgePosition.EdgeDir.TOP_LEFT),
				EdgePosition.new(tile_position.get_neighbor(TilePosition.TileNeighbor.BOTTOM_RIGHT), EdgePosition.EdgeDir.TOP)
			]
		_:
			return []
	
