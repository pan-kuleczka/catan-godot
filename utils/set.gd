class_name Set
extends Resource

# A simple implementation of a Set data structure using dictionaries

var dict : Dictionary

func _init(_dict : Dictionary = {}) -> void:
	dict = _dict

func insert(x) -> void:
	dict[x] = null
	
func has(x) -> bool:
	return x in dict
	
func erase(x) -> bool:
	var exists : bool = has(x)
	dict.erase(x)
	return exists

func clear() -> void:
	dict.clear()

func get_elems() -> Array:
	return dict.keys()
