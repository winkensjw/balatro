extends Node
const ATLAS_TEXTURE_PATH = "res://Original Resources/textures/2x/8BitDeck.png"
const OUTPUT_PATH = "res://Entities/Game/Card/Resources/"
const CARD_WIDTH = 142  # Adjust based on your atlas
const CARD_HEIGHT = 190
const COLUMNS = 13  # Number of cards per row in the atlas

var suits: Array[String] = ["hearts", "clubs", "diamonds", "spades"]
var ranks: Array[String] = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
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


func create_card_resource(index: int, suit: String, rank: String, points: int, atlas: Texture2D, region: Rect2) -> void:
	var atlas_tex: AtlasTexture = AtlasTexture.new()
	atlas_tex.atlas = atlas
	atlas_tex.region = region

	var card_res: CardResource = CardResource.new()
	card_res.score = points
	card_res.texture = atlas_tex
	card_res.suite = _map_suit(suit)

	var save_path = OUTPUT_PATH + str(index) + "_" + rank + "_" + suit + ".tres"
	ResourceSaver.save(card_res, save_path)


## Maps the strings of the suits array to the Suit enum.
## @param suit_string: String the string for the current suit
func _map_suit(suit_string: String) -> GameController.Suit:
	match suit_string:
		"spades":
			return GameController.Suit.SPADES
		"hearts":
			return GameController.Suit.HEARTS
		"clubs":
			return GameController.Suit.CLUBS
		"diamonds":
			return GameController.Suit.DIAMONDS
		_:
			ConsoleAdapter.error("Invalid suit string: %s" % suit_string)
			return GameController.Suit.SPADES  # Default
