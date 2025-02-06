class_name GameMap
extends Resource
	
var tiles : Dictionary
var robber_position : Vector2i
var pirate_position : Vector2i

func _init(_map_scheme : MapScheme) -> void:
	tiles = generate_map(_map_scheme)

#def __str__(self) -> str:
	#return "\n".join([" ".join([str(tile) for tile in row]) for row in tiles])

func generate_map(map_scheme : MapScheme) -> Dictionary:
	var scheme : Dictionary = map_scheme.map_scheme_tiles
	var types : Array[MapTile.MapTileType] = map_scheme.land_tile_types
	var numbers : Array[int] = map_scheme.land_tile_numbers
	types.shuffle()
	numbers.shuffle()
	var current_type_index : int = 0
	var current_number_index : int = 0
	for board_position in scheme.keys():
		if scheme[board_position] == MapScheme.MapSchemeTileType.LAND:
			if current_type_index >= len(types):
				push_warning("generate_map warning: not enough tile types to fill the map")
				continue
			if types[current_type_index] == MapTile.MapTileType.DESERT:
				robber_position = board_position
				tiles[board_position] = MapTile.new(types[current_type_index])
				current_type_index += 1
				continue
			if current_number_index >= len(numbers):
				push_warning("generate_map warning: not enough tile numbers to fill the map")
				continue
			tiles[board_position] = MapTile.new(types[current_type_index], numbers[current_number_index])
			current_type_index += 1
			current_number_index += 1
	return tiles

func get_tile_type(board_position : Vector2i) -> MapTile.MapTileType:
	return tiles[board_position].tile_type

func get_number(board_position : Vector2i) -> int:
	return tiles[board_position].number
