class_name GameMap
extends Resource
	
var tiles : UnorderedMap
var building_positions : UnorderedMap
var robber_position : TilePosition
var pirate_position : TilePosition

func _init(_map_scheme : MapScheme) -> void:
	tiles = generate_map(_map_scheme)
	building_positions = UnorderedMap.new()
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

func get_tile_buildings(tile_position : TilePosition) -> Array[Building]:
	if building_positions.has(tile_position):
		return [building_positions.get_value(tile_position)]
	return []
	
func get_vertex_buildings(tile_position : TilePosition) -> Array[Building]:
	var vertex_buildings : Array[Building] = []
	for position : VertexPosition in tile_position.get_neighbor_vertices():
		if building_positions.has(position):
			vertex_buildings.append(building_positions.get_value(position))
	return vertex_buildings
	
func get_edge_buildings(tile_position : TilePosition) -> Array[Building]:
	var edge_buildings : Array[Building] = []
	for position : EdgePosition in tile_position.get_neighbor_edges():
		if building_positions.has(position):
			edge_buildings.append(building_positions.get_value(position))
	return edge_buildings
	
func trigger_tile_collection(tile_position : TilePosition) -> void:
	if not tiles.has(tile_position):
		return
	var tile : MapTile = tiles.get_value(tile_position)
	var resource : int = tile.get_associated_resource()
	
	var triggered_buildings : Array[Building] = \
		get_tile_buildings(tile_position) \
		+ get_edge_buildings(tile_position) \
		+ get_vertex_buildings(tile_position)
	
	for building : Building in triggered_buildings:
		building.trigger_collection(resource)
