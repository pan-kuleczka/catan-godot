extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pos : TilePosition = TilePosition.new(0, 0)
	$"GameBoard".add_building(pos.get_neighbor_vertices()[0], Settlement.new(PlayerColor.RED))
	$"GameBoard".add_building(pos.get_neighbor_edges()[0], Road.new(PlayerColor.RED))
	print($"GameBoard".map.building_positions.keys())
