class_name Card
extends Resource

func get_node() -> CardScene:
	push_error("The function get_node() has not been overriden in a subclass of Card")
	var card_scene : PackedScene = load("res://cards/scenes/card_scene.tscn")
	return card_scene.instantiate()
