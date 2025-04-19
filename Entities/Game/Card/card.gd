## ============================================================================
## Card.gd
## ============================================================================
## Represents a single card in the game, holding its core properties such as
## score, suit, rank, and texture.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name Card
extends RefCounted

enum Suit { SPADES, HEARTS, CLUBS, DIAMONDS }
enum Rank { TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, J, Q, K, A }

var _card_resource: CardResource

var _score: int
var _suit: Suit
var _rank: Rank
var _selected: bool
var _texture: AtlasTexture

var _card_ui: CardUi

var _card_ui_scene: PackedScene = preload(Constants.CARD_UI_SCENE_PATH)


static func suit_to_string(suit: Card.Suit) -> String:
	match suit:
		Card.Suit.SPADES:
			return "Spades"
		Card.Suit.HEARTS:
			return "Hearts"
		Card.Suit.CLUBS:
			return "Clubs"
		Card.Suit.DIAMONDS:
			return "Diamonds"
		_:
			ConsoleAdapter.error("Invalid suit enum: %s" % suit)
			return "unknown"  # Default


static func rank_to_string(rank: Card.Rank) -> String:
	match rank:
		Card.Rank.TWO:
			return "2"
		Card.Rank.THREE:
			return "3"
		Card.Rank.FOUR:
			return "4"
		Card.Rank.FIVE:
			return "5"
		Card.Rank.SIX:
			return "6"
		Card.Rank.SEVEN:
			return "7"
		Card.Rank.EIGHT:
			return "8"
		Card.Rank.NINE:
			return "9"
		Card.Rank.TEN:
			return "10"
		Card.Rank.J:
			return "J"
		Card.Rank.Q:
			return "Q"
		Card.Rank.K:
			return "K"
		Card.Rank.A:
			return "A"
		_:
			ConsoleAdapter.error("Invalid rank enum: %s" % rank)
			return "unknown"  # Default


func _init(card_resource: CardResource) -> void:
	_card_resource = card_resource
	_score = card_resource.score
	_suit = card_resource.suit
	_rank = card_resource.rank
	_texture = card_resource.texture


## Returns the score of the card.
func get_score() -> int:
	return _score


## Sets the score of the card.
## @param value: int The new score value.
func set_score(value: int) -> void:
	_score = value


## Returns the suit of the card.
func get_suit() -> Suit:
	return _suit


## Sets the suit of the card.
## @param value: Card.Suit The new suit value.
func set_suit(value: Suit) -> void:
	_suit = value


## Returns the rank of the card.
func get_rank() -> Rank:
	return _rank


## Sets the rank of the card.
## @param value: Card.Rank The new rank value.
func set_rank(value: Rank) -> void:
	_rank = value


func is_selected() -> bool:
	return _selected


func set_selected(new_value: bool) -> void:
	_selected = new_value


## Returns the texture of the card.
func get_texture() -> AtlasTexture:
	return _texture


## Sets the texture of the card.
## @param value: AtlasTexture The new texture value.
func set_texture(value: AtlasTexture) -> void:
	_texture = value


## Returns a string representation of the card.
## @return String A string representing the card.
func _to_string() -> String:
	return "[Card: Score=%s, Suit=%s, Rank=%s]" % [_score, Card.suit_to_string(_suit), Card.rank_to_string(_rank)]


func get_ui() -> CardUi:
	if _card_ui == null:
		return render()
	return _card_ui


func render() -> CardUi:
	_card_ui = _card_ui_scene.instantiate()
	_card_ui.set_card(self)
	return _card_ui


func destroy() -> void:
	_card_ui.queue_free()
