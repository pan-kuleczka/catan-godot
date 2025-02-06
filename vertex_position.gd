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

var position : Vector2i
var direction : VertexDir

func _init(_position : Vector2i = Vector2i(0, 0), _direction : VertexDir = VertexDir.LEFT):
	position = _position
	direction = _direction

func get_neighbors() -> Array[Vector2i]:
	match direction:
		VertexDir.LEFT:
			return [
				position,
				MapScheme.get_tile_map_layer().get_neighbor_cell(
					position,
					TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER
				),
				MapScheme.get_tile_map_layer().get_neighbor_cell(
					position,
					TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER
				)
			]
		VertexDir.RIGHT:
			return [
				position,
				MapScheme.get_tile_map_layer().get_neighbor_cell(
					position,
					TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER
				),
				MapScheme.get_tile_map_layer().get_neighbor_cell(
					position,
					TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER
				)
			]
		_:
			return []
