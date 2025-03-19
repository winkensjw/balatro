# =============================================================================
# MainMenu.gd
# =============================================================================
# This script defines the behavior of the main menu scene. It handles button
# presses and initiates corresponding actions, such as opening the options
# dialog or quitting the game.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name MainMenu
extends CanvasLayer

## Logger instance for this class.
var _log: Log = Log.new(self.name)

## PackedScene for the Options Dialog.
@onready var _options_dialog_scene: PackedScene = preload(Constants.OPTIONS_DIALOG_SCENE_PATH)
@onready var _game_setup_scene: PackedScene = preload(Constants.GAME_SETUP_DIALOG_SCENE_PATH)


## Called when the node enters the scene tree for the first time.
## Plays the background music when the main menu is loaded.
func _ready() -> void:
	ResonateAdapter.play_music(Constants.MUSIC_BANK_NAME, Constants.MUSIC_TRACK_BACKGROUND_MUSIC_NAME)


## Called when the profile button is pressed.
func _on_profile_button_pressed() -> void:
	_log.debug("Profile button pressed")


## Called when the language button is pressed.
func _on_language_button_pressed() -> void:
	_log.debug("Language button pressed")


## Called when the collection button is pressed.
func _on_collection_button_pressed() -> void:
	_log.debug("Collection button pressed")


## Called when the quit button is pressed.
func _on_quit_button_pressed() -> void:
	_log.debug("Quit button pressed")
	Events.quit_game_requested.emit()


## Called when the options button is pressed.
func _on_options_button_pressed() -> void:
	_log.debug("Options button pressed")
	Events.show_dialog.emit(_options_dialog_scene, true)


## Called when the play button is pressed.
func _on_play_button_pressed() -> void:
	_log.debug("Play button pressed")
	Events.show_dialog.emit(_game_setup_scene, true)
