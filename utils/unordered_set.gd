class_name UnorderedSet
extends Resource

# A set using the UnorderedMap
var map : UnorderedMap

func _init(_arr : Array = []) -> void:
	map = UnorderedMap.new()
	for x : Variant in _arr:
		insert(x)

func insert(x : Variant) -> void:
	map.set_value(x, true)
	
func has(x : Variant) -> bool:
	return x in map.keys()
	
func erase(x : Variant) -> bool:
	return map.erase(x)

func clear() -> void:
	map.clear()

func get_elems() -> Array[Variant]:
	return map.keys()
