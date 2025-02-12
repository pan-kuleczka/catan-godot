class_name Player
extends Resource

var color : PlayerColor
var inventory : Array[Card]

func _init(_color : PlayerColor) -> void:
	color = _color
	inventory = []

func get_resources_count() -> Dictionary:
	var resources_count : Dictionary = {}
	for card : Card in inventory:
		if card is ResourceCard:
			resources_count[card.resource] += 1
	return resources_count

func can_remove_resources(resources_removed : Dictionary) -> bool:
	var resources_in_inventory : Dictionary = get_resources_count()
	for resource : int in resources_removed.keys():
		if resources_removed[resource] < 1:
			continue
		if not resources_in_inventory.has(resource):
			return false
		if resources_in_inventory[resource] < resources_removed[resource]:
			return false
	return true

func remove_resources(resources_removed : Dictionary) -> bool:
	if not can_remove_resources(resources_removed):
		return false
	var new_inventory : Array[Card] = []
	for card : Card in inventory:
		if card is ResourceCard:
			if resources_removed.has(card.resource) and resources_removed[card.resource] > 0:
				resources_removed[card.resource] -= 1
				continue
		new_inventory.append(card)
	inventory = new_inventory
	return true

func retrieve_random_card() -> Card:
	if inventory.is_empty():
		return null
	var card : Card = inventory.pick_random()
	inventory.erase(card)
	return card
