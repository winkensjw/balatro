class_name GamePlayArea
extends Control

@onready var deck_spawn_position: Marker2D = $DeckSpawnPosition


func _ready() -> void:
	Events.deck_added.connect(_on_deck_added)


func _on_deck_added(deck: Deck) -> void:
	var deck_ui: DeckUi = deck.get_ui()
	add_child(deck_ui)
	deck_ui.global_position = deck_spawn_position.global_position
