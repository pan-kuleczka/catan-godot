extends Control

var inventory : CardInventory

@onready var CardContainer : HBoxContainer = $"CardContainer"

func _ready() -> void:
	inventory = CardInventory.new()

func draw_cards() -> void:
	# Remove all cards from the scene
	for child : Node in CardContainer.get_children():
		child.queue_free()
		CardContainer.remove_child(child)
		
	# Add all cards to the scene
	for card : Card in inventory.get_cards():
		var card_node : Node = card.get_node()
		CardContainer.add_child(card_node)
		
func add_card(card : Card) -> void:
	inventory.add_card(card)
	draw_cards()
