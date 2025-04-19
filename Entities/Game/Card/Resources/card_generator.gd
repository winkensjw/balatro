extends Node
const ATLAS_TEXTURE_PATH = "res://Original Resources/textures/2x/8BitDeck.png"
const OUTPUT_PATH = "res://Entities/Game/Card/Resources/"
const CARD_WIDTH = 142  # Adjust based on your atlas
const CARD_HEIGHT = 190
const COLUMNS = 13  # Number of cards per row in the atlas

var suits: Array[Card.Suit] = [Card.Suit.HEARTS, Card.Suit.CLUBS, Card.Suit.DIAMONDS, Card.Suit.SPADES]
var ranks: Array[Card.Rank] = [Card.Rank.TWO, Card.Rank.THREE, Card.Rank.FOUR, Card.Rank.FIVE, Card.Rank.SIX, Card.Rank.SEVEN, Card.Rank.EIGHT, Card.Rank.NINE, Card.Rank.TEN, Card.Rank.J, Card.Rank.Q, Card.Rank.K, Card.Rank.A]
var points: Array[int] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]


func _ready() -> void:
	var atlas_texture: Texture2D = load(ATLAS_TEXTURE_PATH)
	if not atlas_texture:
		print("Error: Could not load atlas texture.")
		return

	for suit_index in range(suits.size()):
		for rank_index in range(ranks.size()):
			var region: Rect2 = Rect2(rank_index * CARD_WIDTH, suit_index * CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT)
			create_card_resource(rank_index, suits[suit_index], ranks[rank_index], points[rank_index], atlas_texture, region)

	print("All card resources generated successfully!")


func create_card_resource(index: int, suit: Card.Suit, rank: Card.Rank, points_val: int, atlas: Texture2D, region: Rect2) -> void:
	var atlas_tex: AtlasTexture = AtlasTexture.new()
	atlas_tex.atlas = atlas
	atlas_tex.region = region

	var card_res: CardResource = CardResource.new()
	card_res.score = points_val
	card_res.texture = atlas_tex
	card_res.rank = rank
	card_res.suit = suit

	var save_path: String = OUTPUT_PATH + Card.suit_to_string(suit) + "/" + str(index) + "_" + Card.rank_to_string(rank) + "_" + Card.suit_to_string(suit) + ".tres"
	ResourceSaver.save(card_res, save_path)
