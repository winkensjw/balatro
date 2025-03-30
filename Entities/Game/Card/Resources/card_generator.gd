extends Node
const ATLAS_TEXTURE_PATH = "res://Original Resources/textures/2x/8BitDeck.png"
const OUTPUT_PATH = "res://Entities/Game/Card/Resources/"
const CARD_WIDTH = 142  # Adjust based on your atlas
const CARD_HEIGHT = 190
const COLUMNS = 13  # Number of cards per row in the atlas

var suits: Array[GameController.Suit] = [GameController.Suit.HEARTS, GameController.Suit.CLUBS, GameController.Suit.DIAMONDS, GameController.Suit.SPADES]
var ranks: Array[GameController.Rank] = [
	GameController.Rank.TWO,
	GameController.Rank.THREE,
	GameController.Rank.FOUR,
	GameController.Rank.FIVE,
	GameController.Rank.SIX,
	GameController.Rank.SEVEN,
	GameController.Rank.EIGHT,
	GameController.Rank.NINE,
	GameController.Rank.TEN,
	GameController.Rank.J,
	GameController.Rank.Q,
	GameController.Rank.K,
	GameController.Rank.A
]
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


func create_card_resource(index: int, suit: GameController.Suit, rank: GameController.Rank, points_val: int, atlas: Texture2D, region: Rect2) -> void:
	var atlas_tex: AtlasTexture = AtlasTexture.new()
	atlas_tex.atlas = atlas
	atlas_tex.region = region

	var card_res: CardResource = CardResource.new()
	card_res.score = points_val
	card_res.texture = atlas_tex
	card_res.suit = suit

	var save_path: String = OUTPUT_PATH + _map_suit_upper_case(suit) + "/" + str(index) + "_" + _map_rank(rank) + "_" + _map_suit(suit) + ".tres"
	ResourceSaver.save(card_res, save_path)


## Maps the suit enum to the suit string.
## @param suit: GameController.Suit the suit enum value
## @return String the string for the current suit
func _map_suit(suit: GameController.Suit) -> String:
	match suit:
		GameController.Suit.SPADES:
			return "spades"
		GameController.Suit.HEARTS:
			return "hearts"
		GameController.Suit.CLUBS:
			return "clubs"
		GameController.Suit.DIAMONDS:
			return "diamonds"
		_:
			ConsoleAdapter.error("Invalid suit enum: %s" % suit)
			return "unknown"  # Default


func _map_suit_upper_case(suit: GameController.Suit) -> String:
	match suit:
		GameController.Suit.SPADES:
			return "Spades"
		GameController.Suit.HEARTS:
			return "Hearts"
		GameController.Suit.CLUBS:
			return "Clubs"
		GameController.Suit.DIAMONDS:
			return "Diamonds"
		_:
			ConsoleAdapter.error("Invalid suit enum: %s" % suit)
			return "unknown"  # Default


## Maps the rank enum to the rank string.
## @param rank: GameController.Rank the rank enum value
## @return String the string for the current rank
func _map_rank(rank: GameController.Rank) -> String:
	match rank:
		GameController.Rank.TWO:
			return "2"
		GameController.Rank.THREE:
			return "3"
		GameController.Rank.FOUR:
			return "4"
		GameController.Rank.FIVE:
			return "5"
		GameController.Rank.SIX:
			return "6"
		GameController.Rank.SEVEN:
			return "7"
		GameController.Rank.EIGHT:
			return "8"
		GameController.Rank.NINE:
			return "9"
		GameController.Rank.TEN:
			return "10"
		GameController.Rank.J:
			return "J"
		GameController.Rank.Q:
			return "Q"
		GameController.Rank.K:
			return "K"
		GameController.Rank.A:
			return "A"
		_:
			ConsoleAdapter.error("Invalid rank enum: %s" % rank)
			return "unknown"  # Default
