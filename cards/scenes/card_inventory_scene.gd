extends Control

var inventory : CardInventory

@onready var CardsNode : Control = $"Cards"

func _ready() -> void:
	inventory = CardInventory.new()

func calculate_final_card_positions(n_cards : int) -> Array[Vector2]:
	var rect : Rect2 = CardsNode.get_rect()
	var center : Vector2 = rect.get_center()
	var max_cards_per_side : int = n_cards / 2
	var card_width : float = 200 # TODO: This should be done better...
	var offset : float = max((rect.size.x - card_width) / (2 * max_cards_per_side), 0)
	var left_pos : Vector2 = center - Vector2(max_cards_per_side * offset, 0)
	var positions : Array[Vector2] = []
	for i in range(n_cards):
		positions.append(left_pos + Vector2(offset, 0) * i)
	return positions
	
func draw_cards() -> void:
	# Remove all cards from the scene
	for child : Node in CardsNode.get_children():
		child.queue_free()
		CardsNode.remove_child(child)
	
	var cards : Array[Card] = inventory.get_cards()
	var positions : Array[Vector2] = calculate_final_card_positions(len(cards))
	
	# Add all cards to the scene
	for i in range(len(cards)):
		var card : Card = cards[i]
		var card_node : Node = card.get_node()
		card_node.position = positions[i]
		CardsNode.add_child(card_node)
		
func add_card(card : Card) -> void:
	inventory.add_card(card)
	draw_cards()

func _on_button_pressed() -> void:
	add_card(ResourceCard.new(randi() % 5 + 1))
