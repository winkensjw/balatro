## ============================================================================
## GameSetupDialog.gd
## ============================================================================
## A ModalDialog that allows the user to configure the initial settings for a
## new game.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name GameSetupDialog
extends ModalDialog

## The default deck resource to use for the game.
@onready var _default_deck: DeckResource = preload(Constants.STANDARD_DECK_RESOURCE_PATH)


func _on_back_button_pressed() -> void:
	close(true)


func _on_play_button_pressed() -> void:
	close(true)
	Events.scene_change_requested.emit(Constants.GAME_SCENE_PATH, get_setup())


func get_setup() -> GameSetup:
	var setup: GameSetup = GameSetup.new()
	setup.set_max_hands_amount(5)
	setup.set_max_discards_amount(3)
	setup.set_money(0)
	setup.set_ante(1)
	setup.set_ante_target(8)
	setup.set_round(1)
	setup.set_max_hand_size(7)
	setup.set_deck(_default_deck)
	return setup
