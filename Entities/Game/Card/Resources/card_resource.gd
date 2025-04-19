## ============================================================================
## CardResource.gd
## ============================================================================
## Represents the data for a single card in the game, such as its score, suit,
## and visual appearance.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name CardResource
extends Resource

## The numerical score of the card.
@export var score: int

## The suit of the card (e.g., Hearts, Diamonds, Clubs, Spades).
@export var suit: Card.Suit

## The rand of the card (e.g., 2, J, A).
@export var rank: Card.Rank

## The texture used to represent the card visually.
@export var texture: AtlasTexture
