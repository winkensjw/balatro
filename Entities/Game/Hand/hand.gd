class_name Hand
extends RefCounted

var _log: Log = Log.new("Hand")

var _max_hand_size: int = 0
var _cards: Array[Card] = []


func size() -> int:
	return _cards.size()


func can_draw(num: int) -> bool:
	return _max_hand_size - size() >= num


func add_card(card: Card) -> void:
	_cards.append(card)
	Events.hand_changed.emit(self)


## Returns the maximum hand size.
func get_max_hand_size() -> int:
	return _max_hand_size


## Sets the maximum hand size.
## @param size: int The new maximum hand size.
func set_max_hand_size(new_value: int) -> void:
	_log.debug("Setting max hand size to: %s" % new_value)
	_max_hand_size = new_value


## Returns the cards in the hand.
func get_cards() -> Array[Card]:
	return _cards


## Sets the cards in the hand.
## @param cards: Array[Card] The new array of cards.
func set_cards(cards: Array[Card]) -> void:
	_cards = cards
	_log.debug("Setting hand with %s cards." % _cards.size())


func _to_string() -> String:
	var hand_string: String = "["
	for card in _cards:
		hand_string += str(card) + ", "
	if size() > 0:
		hand_string = hand_string.substr(0, hand_string.length() - 2)  # Remove trailing ", "
	hand_string += "]"
	return hand_string
