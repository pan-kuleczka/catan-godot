class_name GameMap
extends Resource
	
var tiles : UnorderedMap
var building_positions : UnorderedMap
var robber_position : TilePosition
var pirate_position : TilePosition

func _init(_map_scheme : MapScheme) -> void:
	tiles = generate_map(_map_scheme)
	robber_position = null
	pirate_position = null

func generate_map(map_scheme : MapScheme) -> UnorderedMap:
	var scheme : UnorderedMap = map_scheme.map_scheme_tiles
	var types : Array[MapTile.MapTileType] = map_scheme.land_tile_types
	var numbers : Array[int] = map_scheme.land_tile_numbers
	types.shuffle()
	numbers.shuffle()
	var current_type_index : int = 0
	var current_number_index : int = 0
	tiles = UnorderedMap.new()
	for board_position in scheme.keys():
		if scheme.get_value(board_position) == MapScheme.MapSchemeTileType.LAND:
			if current_type_index >= len(types):
				push_warning("generate_map warning: not enough tile types to fill the map")
				continue
			if types[current_type_index] == MapTile.MapTileType.DESERT:
				robber_position = board_position
				tiles.set_value(
					board_position,
					MapTile.new(types[current_type_index])
				)
				current_type_index += 1
				continue
			if current_number_index >= len(numbers):
				push_warning("generate_map warning: not enough tile numbers to fill the map")
				continue
			tiles.set_value(
				board_position,
				MapTile.new(types[current_type_index], numbers[current_number_index])
			)
			current_type_index += 1
			current_number_index += 1
	return tiles

func get_existing_tile_positions() -> Array:
	return tiles.keys()

func get_tile_type(tile_position : TilePosition) -> MapTile.MapTileType:
	return tiles.get_value(tile_position).type

func get_tile_number(tile_position : TilePosition) -> int:
	return tiles.get_value(tile_position).number
