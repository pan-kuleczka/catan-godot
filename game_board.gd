extends Control

var map_scheme : MapScheme = MapScheme.MAP_SCHEMES["STANDARD_FOR_4"]
var map : Map

func _ready() -> void:
	map = Map.new(map_scheme)
	generate_board()
	draw_board()

func _process(_delta : float) -> void:
	pass

func generate_board() -> void:
	map.generate_map(map_scheme)

func draw_board() -> void:
	var tiles : Dictionary = map.tiles
	$"Center/BoardLayer".clear()
	$"Center/BoardNumbers".clear()
	for board_position : Vector2i in tiles.keys():
		var tile : BoardTile = tiles[board_position]
		$"Center/BoardLayer".set_cell(
			board_position,
			tile.type,
			Vector2i(0, 0)
			
		)
		$Center/BoardNumbers.set_cell(
			board_position,
			0,
			Vector2i(0, 0),
			tile.number
		)


func _on_generate_board_button_pressed() -> void:
	generate_board()
	draw_board()
