class_name GamePlayArea
extends Control

@onready var deck_spawn_position: Marker2D = $DeckSpawnPosition


func _ready() -> void:
	Events.deck_added.connect(_on_deck_added)
	Events.card_drawn.connect(_on_card_drawn)


func _on_deck_added(deck: Deck) -> void:
	var deck_ui: DeckUi = deck.get_ui()
	add_child(deck_ui)
	deck_ui.global_position = deck_spawn_position.global_position


func _on_card_drawn(card: Card) -> void:
	_spawn_card(card, deck_spawn_position)


func _spawn_card(card: Card, pos: Marker2D) -> void:
	var card_ui: CardUi = card.get_ui()
	add_child(card.get_ui())
	card_ui.global_position = pos.global_position
	card_ui.set_snap_back_position(pos.global_position + card_ui.size / 2)  # snap to middle of deck
