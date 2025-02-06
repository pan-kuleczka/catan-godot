class_name GridPosition
extends Resource

var x : int
var y : int

func _init(_x : int, _y : int) -> void:
	x = _x
	y = _y

func get_neighbors() -> Array[GridPosition]:
	if y % 2 == 1:
		return [
			GridPosition.new(x, y - 1),
			GridPosition.new(x + 1, y + 1),
			GridPosition.new(x, y + 1)
		]
	else:
		return [
			GridPosition.new(x, y - 1),
			GridPosition.new(x - 1, y - 1),
			GridPosition.new(x, y + 1)
		]

#func get_tile_neighbors() -> Array[BoardPosition]:
	#if y % 2 == 1:
		#return [
			#BoardPosition.new(x - 1, y / 2),
			#BoardPosition.new(x, y / 2),
			#BoardPosition.new(x, y / 2 + 1)
		#]
	#else:
		#return [
			#BoardPosition.new(x - 1, y / 2 - 1),
			#BoardPosition.new(x - 1, y / 2),
			#BoardPosition.new(x, y / 2)
		#]
