class_name BoardPosition
extends Resource

var row : int
var column : int

func _init(_row : int, _column : int) -> void:
	row = _row
	column = _column

func get_neighbors() -> Array[BoardPosition]:
	return [
		BoardPosition.new(row - 1, column - 1),
		BoardPosition.new(row - 1, column),
		BoardPosition.new(row, column - 1),
		BoardPosition.new(row, column + 1),
		BoardPosition.new(row + 1, column),
		BoardPosition.new(row + 1, column + 1)
	]

func get_grid_neighbors() -> Array[GridPosition]:
	var top_grid_point : GridPosition = GridPosition.new(row, column * 2)
	var bottom_grid_point : GridPosition = GridPosition.new(row + 1, column * 2 + 1)
	return [
		GridPosition.new(top_grid_point.row, top_grid_point.col - 1),
		top_grid_point,
		GridPosition.new(top_grid_point.row, top_grid_point.col + 1),
		GridPosition.new(bottom_grid_point.row, bottom_grid_point.col - 1),
		bottom_grid_point,
		GridPosition.new(bottom_grid_point.row, bottom_grid_point.col + 1)
	]
