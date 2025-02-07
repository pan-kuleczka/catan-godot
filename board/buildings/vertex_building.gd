class_name VertexBuilding
extends Building

func _init(_player_color : int) -> void:
	super(_player_color)

static func get_positioning_type() -> BuildingPositioningType:
	return BuildingPositioningType.VERTEX
