class_name ResourceCard
extends Card

var resource : int

func _init(_resource : int) -> void:
	resource = _resource

func get_node() -> Node:
	var card_scene : PackedScene = preload("res://cards/scenes/card_scene.tscn")
	var texture_path : String = "res://assets/cards/" + GameResource.e.keys()[resource].to_lower() + ".svg"
	if FileAccess.file_exists(texture_path):
		return card_scene.instantiate().with_data(load(texture_path))
	push_warning("Card with resource " + str(resource) + " does not have a texture at" + texture_path + ", falling back to a default one")
	return card_scene.instantiate()
