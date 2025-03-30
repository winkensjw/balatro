## ============================================================================
## GameSetup.gd
## ============================================================================
## A data class that holds the initial game settings.  This is used to
## configure the GameController when a new game is started.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name GameSetup
extends RefCounted

## The maximum amount of hands the player can have.
var _max_hands_amount: int = 0

## The maximum amount of discards the player can have.
var _max_discards_amount: int = 0

## The amount of money the player starts with.
var _money: int = 0

## The initial ante amount.
var _ante: int = 0

## The target amount for the ante.
var _ante_target: int = 0

## The initial round number.
var _round: int = 0

## The maximum size of the player's hand.
var _max_hand_size: int = 0

## The deck to use for the game.
var _deck: DeckResource


## Returns the maximum amount of hands.
func get_max_hands_amount() -> int:
	return _max_hands_amount


## Sets the maximum amount of hands.
## @param amount: int The new maximum amount of hands.
func set_max_hands_amount(amount: int) -> void:
	_max_hands_amount = amount


## Returns the maximum amount of discards.
func get_max_discards_amount() -> int:
	return _max_discards_amount


## Sets the maximum amount of discards.
## @param amount: int The new maximum amount of discards.
func set_max_discards_amount(amount: int) -> void:
	_max_discards_amount = amount


## Returns the initial amount of money.
func get_money() -> int:
	return _money


## Sets the initial amount of money.
## @param amount: int The new amount of money.
func set_money(amount: int) -> void:
	_money = amount


## Returns the initial ante amount.
func get_ante() -> int:
	return _ante


## Sets the initial ante amount.
## @param amount: int The new ante amount.
func set_ante(amount: int) -> void:
	_ante = amount


## Returns the ante target.
func get_ante_target() -> int:
	return _ante_target


## Sets the ante target.
## @param amount: int The new ante target.
func set_ante_target(amount: int) -> void:
	_ante_target = amount


## Returns the initial round.
func get_round() -> int:
	return _round


## Sets the initial round.
## @param round: int The new initial round.
func set_round(round_val: int) -> void:
	_round = round_val


## Returns the maximum hand size.
func get_max_hand_size() -> int:
	return _max_hand_size


## Sets the maximum hand size.
## @param size: int The new maximum hand size.
func set_max_hand_size(size: int) -> void:
	_max_hand_size = size


## Gets the deck for the game.
func get_deck() -> DeckResource:
	return _deck


## Sets the deck for the game
func set_deck(deck: DeckResource) -> void:
	_deck = deck
