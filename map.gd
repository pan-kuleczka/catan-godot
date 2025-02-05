class_name Map
extends Resource
	
var tiles : Dictionary
var robber_position : BoardPosition
var pirate_position : BoardPosition

func _init(_map_scheme : MapScheme) -> void:
	tiles = generate_map(_map_scheme)
	robber_position = null
	pirate_position = null

#def __str__(self) -> str:
	#return "\n".join([" ".join([str(tile) for tile in row]) for row in tiles])

func generate_map(map_scheme : MapScheme) -> Dictionary:
	var scheme = map_scheme.map_scheme
	var types = map_scheme.land_tile_types
	var numbers = map_scheme.land_tile_numbers
	types.shuffle()
	numbers.shuffle()
	var current_type_index : int = 0
	var current_number_index : int = 0
	for board_position in scheme.keys():
		if scheme[board_position]== MapScheme.MapSchemeTileType.LAND:
			if current_type_index >= len(types):
				push_warning("generate_map warning: not enough tile types to fill the map")
				continue
			if types[current_type_index] == BoardTile.BoardTileType.DESERT:
				robber_position = board_position
				tiles[board_position] = BoardTile.new(types[current_type_index])
				current_type_index += 1
				continue
			if current_number_index >= len(numbers):
				push_warning("generate_map warning: not enough tile numbers to fill the map")
				continue
			tiles[board_position] = BoardTile.new(types[current_type_index], numbers[current_number_index])
			current_type_index += 1
			current_number_index += 1
	return tiles

func get_tile_type(board_position : BoardPosition) -> BoardTile.BoardTileType:
	return tiles[board_position].tile_type

func get_number(board_position : BoardPosition) -> int:
	return tiles[board_position].number
