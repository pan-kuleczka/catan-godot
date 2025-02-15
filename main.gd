extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pos : TilePosition = TilePosition.new(0, 0)
	$"GameBoard".add_building(pos.get_neighbor_vertices()[0], Settlement.new(PlayerColor.RED))
	$"GameBoard".add_building(pos.get_neighbor_edges()[0], Road.new(PlayerColor.RED))
	$"GameBoard".add_building(pos.get_neighbor_edges()[1], Road.new(PlayerColor.GREEN))
	$"GameBoard".add_building(pos.get_neighbor_edges()[2], Road.new(PlayerColor.BLUE))
	$"GameBoard".add_building(pos.get_neighbor_edges()[3], Road.new(PlayerColor.BROWN))
	$"CardInventory".add_card(Card.new())
	$"CardInventory".add_card(Card.new())
	$"CardInventory".add_card(Card.new())
	$"CardInventory".add_card(Card.new())
