extends Control

var _deck: Deck

@onready var _card_ui_scene: PackedScene = preload(Constants.CARD_UI_SCENE_PATH)
@onready var _deck_texture: TextureRect = $VBoxContainer/DeckTexture
@onready var _deck_label: Label = $VBoxContainer/DeckLabel


func _ready() -> void:
	Events.deck_changed.connect(_on_deck_changed)
	Events.card_drawn.connect(_on_card_drawn)


func _on_deck_changed(deck: Deck) -> void:
	_deck = deck
	_update_deck_texture()


func _on_card_drawn(_card: Card) -> void:
	_update_deck_label()
	var card_ui: CardUi = _card_ui_scene.instantiate()
	add_child(card_ui)
	card_ui.set_snap_back_position(_deck_texture.global_position + _deck_texture.size / 2)


func _update_deck_texture() -> void:
	_deck_texture.texture = _deck.get_texture()


func _update_deck_label() -> void:
	_deck_label.text = Strings.join("/", [_deck.get_card_pile_size(), _deck.get_deck_size()])
