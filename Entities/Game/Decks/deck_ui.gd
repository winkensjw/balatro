class_name DeckUi
extends Control

var _deck: Deck

@onready var _deck_texture: TextureRect = $VBoxContainer/DeckTexture
@onready var _deck_label: Label = $VBoxContainer/DeckLabel


func _ready() -> void:
	_deck_texture.texture = _deck.get_texture()
	_update_deck_label()


func _set_deck(deck: Deck) -> void:
	_deck = deck


func _update_deck_label() -> void:
	_deck_label.text = Strings.join("/", [_deck.get_card_pile_size(), _deck.get_deck_size()])


func spawn_card(card: Card) -> void:
	_update_deck_label()
	var card_ui: CardUi = card.get_ui()
	card_ui.enabled = false
	ResonateAdapter.play_sound(Constants.SOUND_BANK_NAME, Constants.SOUND_TRACK_CARD_SOUND)
	card_ui.move_card(self, global_position, true)
	card_ui.enabled = true
