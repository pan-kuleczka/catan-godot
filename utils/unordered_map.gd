class_name UnorderedMap
extends Resource

# This is a Dictionary that supports _eq and _hash functions, so that using
# Dictionaries with objects FINALLY makes sense (why is this not implemented in Godot???)

var dictionary : Dictionary = {}
# Maps hashes to arrays of pairs (key, value)

func _init():
	pass
	
func set_value(key : Variant, value : Variant) -> void:
	var key_hash : int = key._hash()
	if not dictionary.has(key_hash):
		dictionary[key_hash] = []
	for i in range(len(dictionary[key_hash])):
		if dictionary[key_hash][i][0]._eq(key):
			dictionary[key_hash][i][1] = value
			return
	dictionary[key_hash].append([key, value])

func get_value(key : Variant) -> Variant:
	var key_hash : int = key._hash()
	for i in range(len(dictionary[key_hash])):
		if dictionary[key_hash][i][0]._eq(key):
			return dictionary[key_hash][i][1]
	return null

func erase(key : Variant) -> bool:
	var key_hash : int = key._hash()
	for i in range(len(dictionary[key_hash])):
		if dictionary[key_hash][i][0]._eq(key):
			dictionary[key_hash].erase(dictionary[key_hash][i])
			return true
	return false

func has(key : Variant) -> bool:
	return key in keys()

func keys() -> Array[Variant]:
	var ckeys : Array[Variant] = []
	for key_hash in dictionary.keys():
		for p in dictionary[key_hash]:
			ckeys.append(p[0])
	return ckeys

func values() -> Array[Variant]:
	var cvalues : Array[Variant] = []
	for key_hash in dictionary.keys():
		for p in dictionary[key_hash]:
			cvalues.append(p[1])
	return cvalues

func clear() -> void:
	dictionary.clear()
