class_name MapScheme
extends Resource

enum MapSchemeTileType {LAND, OCEAN}

var map_scheme : Dictionary
var land_tile_types : Array[BoardTile.BoardTileType]
var land_tile_numbers : Array[int]
var port_positions : Array[EdgePosition]

func _init(
		_map_scheme : Dictionary,
		_land_tile_types : Array[BoardTile.BoardTileType],
		_land_tile_numbers : Array[int],
		_port_positions : Array[EdgePosition]
		) -> void:
	if len(_land_tile_numbers) > len(_land_tile_types):
		push_warning("MapScheme _init: len(_land_tile_numbers) > len(_land_tile_types)")
	while len(_land_tile_numbers) > len(_land_tile_types):
		_land_tile_types.append(BoardTile.BoardTileType.EMPTY)
		
	map_scheme = _map_scheme
	land_tile_types = _land_tile_types
	land_tile_numbers = _land_tile_numbers
	port_positions = _port_positions

static var MAP_SCHEMES : Dictionary = {
	"STANDARD_FOR_4" : MapScheme.new(
		{
			Vector2i(-2, -1) : MapSchemeTileType.LAND,
			Vector2i(-2, 0) : MapSchemeTileType.LAND,
			Vector2i(-2, 1) : MapSchemeTileType.LAND,
			Vector2i(-1, -2) : MapSchemeTileType.LAND,
			Vector2i(-1, -1) : MapSchemeTileType.LAND,
			Vector2i(-1, 0) : MapSchemeTileType.LAND,
			Vector2i(-1, 1) : MapSchemeTileType.LAND,
			Vector2i(-1, 2) : MapSchemeTileType.LAND,
			Vector2i(0, -2) : MapSchemeTileType.LAND,
			Vector2i(0, -1) : MapSchemeTileType.LAND,
			Vector2i(0, 0) : MapSchemeTileType.LAND,
			Vector2i(0, 1) : MapSchemeTileType.LAND,
			Vector2i(0, 2) : MapSchemeTileType.LAND,
			Vector2i(1, -2) : MapSchemeTileType.LAND,
			Vector2i(1, -1) : MapSchemeTileType.LAND,
			Vector2i(1, 0) : MapSchemeTileType.LAND,
			Vector2i(1, 1) : MapSchemeTileType.LAND,
			Vector2i(1, 2) : MapSchemeTileType.LAND,
			Vector2i(2, 0) : MapSchemeTileType.LAND,
		},
		
		[
			BoardTile.BoardTileType.BRICK_QUARRY, BoardTile.BoardTileType.BRICK_QUARRY, BoardTile.BoardTileType.BRICK_QUARRY,
			BoardTile.BoardTileType.FOREST, BoardTile.BoardTileType.FOREST, BoardTile.BoardTileType.FOREST, BoardTile.BoardTileType.FOREST,
			BoardTile.BoardTileType.PASTURE, BoardTile.BoardTileType.PASTURE, BoardTile.BoardTileType.PASTURE, BoardTile.BoardTileType.PASTURE,
			BoardTile.BoardTileType.WHEAT_FIELD, BoardTile.BoardTileType.WHEAT_FIELD, BoardTile.BoardTileType.WHEAT_FIELD, BoardTile.BoardTileType.WHEAT_FIELD,
			BoardTile.BoardTileType.QUARRY, BoardTile.BoardTileType.QUARRY, BoardTile.BoardTileType.QUARRY,
			BoardTile.BoardTileType.DESERT
		],
		
		[2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12],
		
		[
			#(GridPosition(0, 0), GridPosition(0, 1)),
			#(GridPosition(0, 2), GridPosition(0, 3)),
			#(GridPosition(0, 4), GridPosition(0, 5)),
			#(GridPosition(1, 0), GridPosition(1, 1)),
			#(GridPosition(1, 4), GridPosition(1, 5)),
			#(GridPosition(2, 0), GridPosition(2, 1)),
			#(GridPosition(2, 5), GridPosition(3, 0)),
			#(GridPosition(3, 4), GridPosition(3, 5)),
			#(GridPosition(4, 0), GridPosition(4, 1)),
			#(GridPosition(4, 2), GridPosition(4, 3))
		],
	)
}
