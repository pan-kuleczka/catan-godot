class_name ResourceCard
extends Card

var resource : GameResource

func _init(_resource : GameResource) -> void:
	resource = _resource

func get_node() -> Node:
	return Node.new()
