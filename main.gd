# =============================================================================
# main.gd
# =============================================================================
# This script represents the main game scene and handles the initialization of
# core systems and scene transitions.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node2D

## The log object used throughout the game for logging messages.
## It is initialized with the name of this script's class.
var _log: Log = Log.new(self.name)

## The current scene being displayed in the game.
var _current_scene: Node


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Initializes the console adapter.
	ConsoleAdapter.init()

	## Connects signals for scene loading, main menu closing, and quit requests.
	Events.load_complete.connect(_on_scene_changed)
	Events.main_menu_closed.connect(_on_main_menu_closed)
	Events.quit_game_requested.connect(_on_quit_game_requested)

	_add_audio()
	_add_crt()
	_add_modal_manager()
	_add_main_menu.call_deferred()


## Adds the audio scene to the game.
func _add_audio() -> void:
	add_child(load(Constants.AUDIO_SCENE_PATH).instantiate())


## Adds the crt filter to the game.
func _add_crt() -> void:
	add_child(load(Constants.CRT_FTILER_SCENE_PATH).instantiate())


func _add_modal_manager() -> void:
	add_child(ModalManager.new())


## Adds the main menu scene to the game.
func _add_main_menu() -> void:
	SceneManager.change_scenes(Constants.MAIN_MENU_SCENE_PATH, self, null, "no_transition")


## Called when a new scene is loaded.
## @param loaded_scene The loaded scene.
func _on_scene_changed(loaded_scene: Node) -> void:
	_current_scene = loaded_scene


## Called when the main menu is closed.
func _on_main_menu_closed() -> void:
	SceneManager.change_scenes(Constants.GAME_SCENE_PATH, self, _current_scene)


## Called when the game is requested to quit.
func _on_quit_game_requested() -> void:
	_log.info("Quit requested. Shutting down.")
	get_tree().quit()
