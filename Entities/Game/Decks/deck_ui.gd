class_name DeckUi
extends Control

var _deck: Deck

@onready var _deck_texture: TextureRect = $VBoxContainer/DeckTexture
@onready var _deck_label: Label = $VBoxContainer/DeckLabel


func _ready() -> void:
	Events.card_drawn.connect(_on_card_drawn)

	_deck_texture.texture = _deck.get_texture()
	_update_deck_label()


func _set_deck(deck: Deck) -> void:
	_deck = deck


func _on_card_drawn(_card: Card) -> void:
	_update_deck_label()


func _update_deck_label() -> void:
	_deck_label.text = Strings.join("/", [_deck.get_card_pile_size(), _deck.get_deck_size()])
