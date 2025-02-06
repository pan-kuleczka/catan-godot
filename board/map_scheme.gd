class_name MapScheme
extends Resource

enum MapSchemeTileType {LAND, OCEAN}

var map_scheme_tiles : Dictionary
var land_tile_types : Array[MapTile.MapTileType]
var land_tile_numbers : Array[int]
var port_positions : Array[EdgePosition]

static func get_tile_map_layer() -> TileMapLayer:
	var tile_set : TileSet = TileSet.new()
	tile_set.tile_shape = TileSet.TILE_SHAPE_HEXAGON
	tile_set.tile_layout = tile_set.TileLayout.TILE_LAYOUT_DIAMOND_RIGHT
	tile_set.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	var tile_map_layer : TileMapLayer = TileMapLayer.new()
	tile_map_layer.tile_set = tile_set
	return tile_map_layer

func _init(
		_map_scheme_tiles : Dictionary,
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

static func _generate_map_scheme_tiles(max_land_dist : int):
	var generated_map_scheme_tiles : Dictionary = {}
	
	# Assuming the Map_tile_set.tres settings, that is
	# 1. A hexagonal TileMap
	# 2. Diamond right Layout
	
	
	var current_tiles : Set = Set.new({Vector2i(0, 0) : null})
	var next_tiles : Set = Set.new()
	
	for i in range(max_land_dist):
		next_tiles.clear()
		for tile in current_tiles.get_elems():
			for neighbor in get_tile_map_layer().get_surrounding_cells(tile):
				next_tiles.insert(neighbor)
			next_tiles.insert(tile)
		current_tiles = next_tiles
		next_tiles = Set.new()
		
	for tile in current_tiles.get_elems():
		generated_map_scheme_tiles[tile] = MapSchemeTileType.LAND
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
