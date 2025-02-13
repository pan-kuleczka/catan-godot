class_name Building
extends Resource

var player_color : int

func _init(_player_color : int) -> void:
	player_color = _player_color

func get_node() -> Node2D:
	push_error("The function get_node() has not been overriden in a subclass of Building")
	var texture : CompressedTexture2D = load("res://assets/buildings/circle.svg")
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = texture
	sprite.modulate = PlayerColor.get_rgb(player_color)
	return sprite

static func get_cost() -> Dictionary:
	push_error("The function get_cost() has not been overriden in a subclass of Building")
	return {}

static func get_prerequisite_building() -> Type:
	return Type.any_type()
	
static func get_tile_triggered_resources_received_multiplier() -> int:
	return 0
	
func trigger_collection(resource : int) -> void:
	var multiplier : int = get_tile_triggered_resources_received_multiplier()
	print(self, " collected ", multiplier, " resources of type ", resource)
	return
