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

var _card_resource: CardResource

var _score: int
var _suit: GameController.Suit
var _rank: GameController.Rank
var _texture: AtlasTexture


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
func get_suit() -> GameController.Suit:
	return _suit


## Sets the suit of the card.
## @param value: GameController.Suit The new suit value.
func set_suit(value: GameController.Suit) -> void:
	_suit = value


## Returns the rank of the card.
func get_rank() -> GameController.Rank:
	return _rank


## Sets the rank of the card.
## @param value: GameController.Rank The new rank value.
func set_rank(value: GameController.Rank) -> void:
	_rank = value


## Returns the texture of the card.
func get_texture() -> AtlasTexture:
	return _texture


## Sets the texture of the card.
## @param value: AtlasTexture The new texture value.
func set_texture(value: AtlasTexture) -> void:
	_texture = value
