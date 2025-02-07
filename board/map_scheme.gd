class_name MapScheme
extends Resource

enum MapSchemeTileType {LAND, OCEAN}

var map_scheme_tiles : UnorderedMap
var land_tile_types : Array[MapTile.MapTileType]
var land_tile_numbers : Array[int]
var port_positions : Array[EdgePosition]

func _init(
		_map_scheme_tiles : UnorderedMap,
		_land_tile_types : Array[MapTile.MapTileType],
		_land_tile_numbers : Array[int],
		_port_positions : Array[EdgePosition]
		) -> void:
	if len(_land_tile_numbers) > len(_land_tile_types):
		push_warning("MapScheme _init: len(_land_tile_numbers) > len(_land_tile_types)")
	while len(_land_tile_numbers) > len(_land_tile_types):
		_land_tile_types.append(MapTile.MapTileType.EMPTY)
		
	map_scheme_tiles = _map_scheme_tiles
	land_tile_types = _land_tile_types
	land_tile_numbers = _land_tile_numbers
	port_positions = _port_positions

static func _generate_map_scheme_tiles(max_land_dist : int) -> UnorderedMap:
	var generated_map_scheme_tiles : UnorderedMap = UnorderedMap.new()
	
	var current_tiles : UnorderedSet = UnorderedSet.new([TilePosition.new(0, 0)])
	var next_tiles : UnorderedSet = UnorderedSet.new()
	
	for i in range(max_land_dist):
		next_tiles.clear()
		for tile_position : TilePosition in current_tiles.get_elems():
			for neighbor : TilePosition in tile_position.get_neighbors():
				next_tiles.insert(neighbor)
			next_tiles.insert(tile_position)
		current_tiles = next_tiles
		next_tiles = UnorderedSet.new()
		
	for tile_position in current_tiles.get_elems():
		generated_map_scheme_tiles.set_value(tile_position, MapSchemeTileType.LAND)

	return generated_map_scheme_tiles
			

static var MAP_SCHEMES : Dictionary = {
	"STANDARD_FOR_4" : MapScheme.new(
		_generate_map_scheme_tiles(2),		
		[
			MapTile.MapTileType.BRICK_QUARRY, MapTile.MapTileType.BRICK_QUARRY, MapTile.MapTileType.BRICK_QUARRY,
			MapTile.MapTileType.FOREST, MapTile.MapTileType.FOREST, MapTile.MapTileType.FOREST, MapTile.MapTileType.FOREST,
			MapTile.MapTileType.PASTURE, MapTile.MapTileType.PASTURE, MapTile.MapTileType.PASTURE, MapTile.MapTileType.PASTURE,
			MapTile.MapTileType.WHEAT_FIELD, MapTile.MapTileType.WHEAT_FIELD, MapTile.MapTileType.WHEAT_FIELD, MapTile.MapTileType.WHEAT_FIELD,
			MapTile.MapTileType.QUARRY, MapTile.MapTileType.QUARRY, MapTile.MapTileType.QUARRY,
			MapTile.MapTileType.DESERT
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
