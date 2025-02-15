class_name Player
extends Resource

var color : PlayerColor
var inventory : CardInventory

func _init(_color : PlayerColor) -> void:
	color = _color
	inventory = CardInventory.new()
