class_name TilePosition
extends BoardPosition

# Basically a Vector2i upgrade
enum TileNeighbor
{
	TOP_LEFT,
	TOP,
	TOP_RIGHT,
	BOTTOM_RIGHT,
	BOTTOM,
	BOTTOM_LEFT
}

var position : Vector2i

func _init(_x : int, _y : int) -> void:
	position = Vector2i(_x, _y)

func _hash() -> int:
	return hash(position)

func _eq(other : Variant) -> bool:
	if not other is TilePosition:
		return false
	return position == other.position

func _to_string() -> String:
	return str(position)
	
static func from_vec2i(v : Vector2i) -> TilePosition:
	return TilePosition.new(v.x, v.y)

func to_vec2i() -> Vector2i:
	return position

func get_neighbor(tile_neighbor : TileNeighbor) -> TilePosition:
	match tile_neighbor:
		TileNeighbor.TOP_LEFT:
			return TilePosition.new(x, y - 1)
		TileNeighbor.TOP:
			return TilePosition.new(x + 1, y - 1)
		TileNeighbor.TOP_RIGHT:
			return TilePosition.new(x + 1, y)
		TileNeighbor.BOTTOM_RIGHT:
			return TilePosition.new(x, y + 1)
		TileNeighbor.BOTTOM:
			return TilePosition.new(x - 1, y + 1)
		TileNeighbor.BOTTOM_LEFT:
			return TilePosition.new(x - 1, y)
		_:
			return self
			
func get_neighbors() -> Array[TilePosition]:
	var neighbors : Array[TilePosition] = []
	for n in TileNeighbor.values():
		neighbors.append(get_neighbor(n))
	return neighbors
	
func get_neighbor_vertices() -> Array[VertexPosition]:
	return [
		VertexPosition.new(self, VertexPosition.VertexDir.LEFT),
		VertexPosition.new(self, VertexPosition.VertexDir.RIGHT),
		VertexPosition.new(get_neighbor(TileNeighbor.TOP_LEFT), VertexPosition.VertexDir.RIGHT),
		VertexPosition.new(get_neighbor(TileNeighbor.TOP_RIGHT), VertexPosition.VertexDir.LEFT),
		VertexPosition.new(get_neighbor(TileNeighbor.BOTTOM_LEFT), VertexPosition.VertexDir.RIGHT),
		VertexPosition.new(get_neighbor(TileNeighbor.BOTTOM_RIGHT), VertexPosition.VertexDir.LEFT)
	]
	
func get_neighbor_edges() -> Array[EdgePosition]:
	return [
		EdgePosition.new(self, EdgePosition.EdgeDir.TOP_LEFT),
		EdgePosition.new(self, EdgePosition.EdgeDir.TOP),
		EdgePosition.new(self, EdgePosition.EdgeDir.TOP_RIGHT),
		EdgePosition.new(get_neighbor(TileNeighbor.BOTTOM_LEFT), EdgePosition.EdgeDir.TOP_RIGHT),
		EdgePosition.new(get_neighbor(TileNeighbor.BOTTOM), EdgePosition.EdgeDir.TOP),
		EdgePosition.new(get_neighbor(TileNeighbor.BOTTOM_RIGHT), EdgePosition.EdgeDir.TOP_LEFT)
	]
	
# Interface to interact with the Vector2i	
var x : int:
	set(new_value):
		position.x = new_value
	get():
		return position.x

var y : int:
	set(new_value):
		position.y = new_value
	get():
		return position.y
