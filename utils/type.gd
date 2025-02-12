class_name Type
extends Resource

var type : String

func _init(_type : String):
	type = _type

static func get_type(x : Variant) -> Type:
	if x is Object:
		return Type.new(x.get_class())
	return Type.new(type_string(typeof(x)))
	
static func any_type() -> Type:
	return Type.new("ANY")

func is_of_type(x : Variant) -> bool:
	if type == "ANY":
		return true
	if x is Object:
		return x.is_class(type)
	return type_string(typeof(x)) == type
