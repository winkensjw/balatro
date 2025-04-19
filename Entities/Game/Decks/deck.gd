class_name Deck
extends RefCounted

var _log: Log = Log.new("Deck")

var _deck_resource: DeckResource
var _discard_pile: Array[Card]
var _card_pile: Array[Card]
var _texture: AtlasTexture
var _deck_size: int

var _deck_ui: DeckUi

var _deck_ui_scene: PackedScene = preload(Constants.DECK_UI_SCENE_PATH)


## Called when the node is initialized,
## @param deck_resource: DeckResource
func _init(deck_resource: DeckResource) -> void:
	_log.debug("Initializing Deck")
	_deck_resource = deck_resource
	_texture = deck_resource.texture

	# Create Card objects from CardResource objects.
	_card_pile.resize(_deck_resource.card_resources.size())
	for i in range(_deck_resource.card_resources.size()):
		_card_pile[i] = Card.new(_deck_resource.card_resources[i])

	_deck_size = _card_pile.size()
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
		_deck_ui.spawn_card(card)
		return card

	_log.warn("Deck is empty, cannot draw card.")
	Events.game_lost.emit()
	return null


func get_deck_size() -> int:
	return _deck_size


## Returns the number of cards remaining in the deck.
## @return int The number of cards in the deck.
func get_card_pile_size() -> int:
	return _card_pile.size()


## Returns the number of dicarded cards
## @return int The number of cards in the discard pile
func get_discard_pile_size() -> int:
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


## Returns a string representation of the Deck.
func _to_string() -> String:
	return "[Deck: Card Pile Count=%s, Discard Pile Count=%s]" % [_card_pile.size(), _discard_pile.size()]


func get_ui() -> DeckUi:
	if _deck_ui == null:
		return render()
	return _deck_ui


func render() -> DeckUi:
	_deck_ui = _deck_ui_scene.instantiate()
	_deck_ui._set_deck(self)
	return _deck_ui


func destroy() -> void:
	_deck_ui.queue_free()
