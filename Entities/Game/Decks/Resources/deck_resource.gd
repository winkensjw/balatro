## ============================================================================
## DeckResource.gd
## ============================================================================
## Represents a collection of CardResource objects, defining a deck of cards.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name DeckResource
extends Resource

@export_group("Deck")
## The texture that is used for the back of the deck
@export var texture: AtlasTexture

@export_group("Cards")
## An array of CardResource objects that make up the deck.
@export var card_resources: Array[CardResource]
