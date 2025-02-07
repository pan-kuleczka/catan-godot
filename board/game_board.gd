extends Control

var map_scheme : MapScheme = MapScheme.MAP_SCHEMES["STANDARD_FOR_4"]
var map : GameMap

func _ready() -> void:
	map = GameMap.new(map_scheme)
	generate_board()
	draw_board()

func _process(_delta : float) -> void:
	pass

func generate_board() -> void:
	map.generate_map(map_scheme)

func draw_board() -> void:
	$"Center/BoardLayer".clear()
	$"Center/BoardNumbers".clear()
	for tile_position : TilePosition in map.get_existing_tile_positions():
		$"Center/BoardLayer".set_cell(
			tile_position.to_vec2i(),
			map.get_tile_type(tile_position),
			Vector2i(0, 0)
			
		)
		$Center/BoardNumbers.set_cell(
			tile_position.to_vec2i(),
			0,
			Vector2i(0, 0),
			map.get_tile_number(tile_position)
		)

func _on_generate_board_button_pressed() -> void:
	generate_board()
	draw_board()
