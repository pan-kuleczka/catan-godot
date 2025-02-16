extends Control

var inventory : CardInventory

@onready var CardsNode : Control = $"Cards"

func _ready() -> void:
	inventory = CardInventory.new()

func calculate_final_card_positions(n_cards : int) -> Array[Vector2]:
	var center : Vector2 = CardsNode.size / 2
	var card_width : float = 200 # TODO: This should be done better...
	var offset : float = max((CardsNode.size.x - card_width) / (n_cards + 1), 0)
	var left_pos : Vector2 = Vector2(card_width / 2 + offset, center.y)
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
		var card_node : CardScene = card.get_node()
		CardsNode.add_child(card_node)
		card_node.position = positions[i]

func get_cards() -> Array[Card]:
	return inventory.get_cards()
	
func get_n_cards() -> int:
	return len(inventory.get_cards())
		
func add_card(card : Card) -> void:
	inventory.add_card(card)
	
	# Shift the cards
	var new_positions : Array[Vector2] = calculate_final_card_positions(get_n_cards())
	for i in range(get_n_cards() - 1):
		var shifted_card_node : CardScene = CardsNode.get_child(i)
		var tween = get_tree().create_tween()
		tween.tween_property(shifted_card_node, "position", new_positions[i], .3).set_trans(Tween.TRANS_SINE)
		
	# Add the final card
	var card_node : CardScene = card.get_node()
	CardsNode.add_child(card_node)
	card_node.position = new_positions.back()
	card_node.play_arrive()
	
func _on_button_pressed() -> void:
	add_card(ResourceCard.new(randi() % 5 + 1))
