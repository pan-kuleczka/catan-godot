extends Control

var map : Map

func _ready() -> void:
	map = Map.new(MapScheme.MAP_SCHEMES["STANDARD_FOR_4"])
	draw_board(map.tiles)

func _process(delta : float) -> void:
	pass


func draw_board(tiles : Dictionary) -> void:
	$"Center/BoardLayer".clear()
	$"Center/BoardNumbers".clear()
	print(tiles)
	for board_position : BoardPosition in tiles.keys():
		var grid_layer_position : Vector2i = Vector2i(board_position.column, board_position.row)
		var tile : BoardTile = tiles[board_position]
		$"Center/BoardLayer".set_cell(
			grid_layer_position,
			tile.type,
			Vector2i(0, 0)
			
		)
		$Center/BoardNumbers.set_cell(
			grid_layer_position,
			tile.number,
			Vector2i(0, 0)
		)
