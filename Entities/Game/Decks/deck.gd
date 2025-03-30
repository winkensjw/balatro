class_name Deck
extends Node

var _log: Log = Log.new("Deck")

var _deck_resource: DeckResource
var _discard_pile: Array[Card]
var _card_pile: Array[Card]
var _texture: AtlasTexture


## Called when the node is initialized,
## @param deck_resource: DeckResource
func _init(deck_resource: DeckResource) -> void:
	_log.debug("Initializing Deck")
	ConsoleAdapter.add_command("draw_card", draw_card)
	_deck_resource = deck_resource
	_texture = deck_resource.texture

	# Create Card objects from CardResource objects.
	_card_pile.resize(_deck_resource.card_resources.size())
	for i in range(_deck_resource.card_resources.size()):
		_card_pile[i] = Card.new(_deck_resource.card_resources[i])
	shuffle()


## Shuffles the deck.
func shuffle() -> void:
	_card_pile.append_array(_discard_pile)
	_card_pile.shuffle()
	_log.debug("Deck shuffled.")


## Draws a card from the deck.
## @return Card The drawn card, or null if the deck is empty.
func draw_card() -> Card:
	if _card_pile.size() > 0:
		var card: Card = _card_pile.pop_front()
		_log.debug("Card drawn. %s Remaining cards: %s" % [card, _card_pile.size()])
		return card

	_log.warn("Deck is empty, cannot draw card.")
	return null  # FIXME end game here


## Returns the number of cards remaining in the deck.
## @return int The number of cards in the deck.
func get_card_pile_count() -> int:
	return _card_pile.size()


## Returns the number of dicarded cards
## @return int The number of cards in the discard pile
func get_discard_pile_count() -> int:
	return _discard_pile.size()


## Returns the remaining cards
func get_card_pile() -> Array[Card]:
	return _card_pile


## Returns the discarded cards
func get_discard_pile() -> Array[Card]:
	return _discard_pile


func get_texture() -> AtlasTexture:
	return _texture


func set_texture(value: AtlasTexture) -> void:
	_texture = value
