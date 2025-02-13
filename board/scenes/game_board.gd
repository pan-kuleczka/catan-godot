extends Control

var map_scheme : MapScheme = MapScheme.MAP_SCHEMES["STANDARD_FOR_4"]
var map : GameMap

@onready var Center : Control = $"Center"
@onready var BoardLayer : TileMapLayer = $"Center/BoardLayer"
@onready var BoardNumbers : TileMapLayer = $"Center/BoardNumbers"
@onready var Buildings : Control = $"Center/BoardLayer/Buildings"

func _ready() -> void:
	map = GameMap.new(map_scheme)
	generate_board()
	draw_board()

func _process(_delta : float) -> void:
	pass

func generate_board() -> void:
	map.generate_map(map_scheme)

func get_tile_size() -> Vector2:
	return BoardLayer.tile_set.tile_size

func get_center_position() -> Vector2:
	return Center.position

func tile_position_to_screen_position(tile_position : TilePosition) -> Vector2:
	return BoardLayer.map_to_local(tile_position.to_vec2i())
	
func tile_position_to_offset(tile_position : TilePosition) -> Vector2:
	return tile_position_to_screen_position(tile_position) - tile_position_to_screen_position(TilePosition.new(0, 0))

func vertex_position_to_screen_position(vertex_position : VertexPosition) -> Vector2:
	var tile_position : Vector2 = tile_position_to_screen_position(vertex_position.tile_position)
	match vertex_position.direction:
		VertexPosition.VertexDir.LEFT:
			return tile_position + tile_position_to_offset(TilePosition.new(-1, -1)) / 3
		VertexPosition.VertexDir.RIGHT:
			return tile_position - tile_position_to_offset(TilePosition.new(-1, -1)) / 3
	return tile_position
	
func edge_position_to_screen_position(edge_position : EdgePosition) -> Vector2:
	var tile_position : Vector2 = tile_position_to_screen_position(edge_position.tile_position)
	match edge_position.direction:
		EdgePosition.EdgeDir.TOP_LEFT:
			return tile_position + tile_position_to_offset(TilePosition.new(0, -1)) / 2
		EdgePosition.EdgeDir.TOP:
			return tile_position + tile_position_to_offset(TilePosition.new(1, -1)) / 2
		EdgePosition.EdgeDir.TOP_RIGHT:
			return tile_position + tile_position_to_offset(TilePosition.new(1, 0)) / 2
	return tile_position

func _draw_tiles() -> void:
	BoardLayer.clear()
	BoardNumbers.clear()
	for tile_position : TilePosition in map.get_existing_tile_positions():
		BoardLayer.set_cell(
			tile_position.to_vec2i(),
			map.get_tile_type(tile_position),
			Vector2i(0, 0)
			
		)
		BoardNumbers.set_cell(
			tile_position.to_vec2i(),
			0,
			Vector2i(0, 0),
			map.get_tile_number(tile_position)
		)
		
func _draw_buildings() -> void:
	# Remove all buildings from the scene
	for child : Node in Buildings.get_children():
		child.queue_free()
		Buildings.remove_child(child)
		
	# Add all buildings to the scene
	for building_position : BoardPosition in map.building_positions.keys():
		var building : Building = map.building_positions.get_value(building_position)
		var screen_position : Vector2 = Vector2(0, 0)
		if building_position is TilePosition:
			screen_position = tile_position_to_screen_position(building_position)
		elif building_position is VertexPosition:
			screen_position = vertex_position_to_screen_position(building_position)
		elif building_position is EdgePosition:
			screen_position = edge_position_to_screen_position(building_position)
		
		# Create a new Node for the building
		var building_node : Node2D = building.get_node()
		building_node.position = screen_position
		Buildings.add_child(building_node)

func draw_board() -> void:
	_draw_tiles()
	_draw_buildings()

func _on_generate_board_button_pressed() -> void:
	map.building_positions.set_value(VertexPosition.new(TilePosition.new(randi() % 3, randi() % 3)), Settlement.new(0))
	generate_board()
	draw_board()
