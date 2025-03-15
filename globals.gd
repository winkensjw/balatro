# =============================================================================
# globals.gd
# =============================================================================
# This script manages global game settings, including audio volume, game speed,
# shadow settings, and window mode. It also handles saving and loading these
# settings.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node

enum WindowMode { FULL_SCREEN, WINDOWED, BORDERLESS }
enum GameSpeed { SPEED_1, SPEED_2, SPEED_3, SPEED_4 }

## Save identifier for persistent data.
const SAVE_ID: String = "f8a7b6c5-d4e3-2f1g-h0i9-j8k7l6m5n4o3"

## Version identifier for save data.
const VERSION_ID: String = "1"

## Logger instance for this class.
var _log: Log = Log.new(self.name)

## Audio volume setting for the master bus.
var _master_volume_db: float = 0.0

## Audio volume setting for the music bus.
var _music_volume_db: float = 0.0

## Audio volume setting for the game's sound effects bus.
var _game_volume_db: float = 0.0

## Game speed setting.
var _game_speed: GameSpeed = GameSpeed.SPEED_1

## Shadow setting.
var _shadows_enabled: bool = true

## Window mode setting.  Controls the window display mode.
var _window_mode: WindowMode = WindowMode.WINDOWED


## Called when the node enters the scene.  Initializes settings.
func _ready() -> void:
	add_to_group("persistable")

	load_data()

	_apply_window_mode()
	_apply_volume_settings()


## Gets the master volume in decibels.
## @return The master volume in decibels.
func get_master_volume_db() -> float:
	return _master_volume_db


## Sets the master volume in decibels.
## @param value The new master volume in decibels.
func set_master_volume_db(value: float) -> void:
	_master_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


## Gets the music volume in decibels.
## @return The music volume in decibels.
func get_music_volume_db() -> float:
	return _music_volume_db


## Sets the music volume in decibels.
## @param value The new music volume in decibels.
func set_music_volume_db(value: float) -> void:
	_music_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


## Gets the game volume in decibels.
## @return The game volume in decibels.
func get_game_volume_db() -> float:
	return _game_volume_db


## Sets the game volume in decibels.
## @param value The new game volume in decibels.
func set_game_volume_db(value: float) -> void:
	_game_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


## Gets the game speed.
## @return The game speed.
func get_game_speed() -> GameSpeed:
	return _game_speed


## Sets the game speed.
## @param value The new game speed.
func set_game_speed(value: GameSpeed) -> void:
	_game_speed = value
	Events.settings_changed.emit()


## Gets whether shadows are enabled.
## @return True if shadows are enabled, false otherwise.
func is_shadows_enabled() -> bool:
	return _shadows_enabled


## Sets whether shadows are enabled.
## @param enabled True to enable shadows, false to disable.
func set_shadows_enabled(enabled: bool) -> void:
	_shadows_enabled = enabled
	Events.settings_changed.emit()


## Gets the window mode.
## @return The window mode.
func get_window_mode() -> WindowMode:
	return _window_mode


## Sets the window mode.
## @param mode The new window mode.
func set_window_mode(mode: WindowMode) -> void:
	_window_mode = mode
	_apply_window_mode()
	Events.settings_changed.emit()


## Applies the volume settings.  Calls `ResonateAdapter.update_volume`.
func _apply_volume_settings() -> void:
	ResonateAdapter.update_volume()


## Applies the window mode.
func _apply_window_mode() -> void:
	match _window_mode:
		WindowMode.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		WindowMode.FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		WindowMode.BORDERLESS:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


## Gets the save identifier.
## @return The save identifier.
func get_save_id() -> String:
	return SAVE_ID


## Saves all relevant global settings.
## @return A dictionary containing the saved settings data.
func save_data() -> Dictionary:
	_log.info("Saving settings")  # Use _log here!
	var data: Dictionary = {}
	data["version_id"] = VERSION_ID
	data["master_volume_db"] = _master_volume_db
	data["music_volume_db"] = _music_volume_db
	data["game_volume_db"] = _game_volume_db
	data["game_speed"] = _game_speed_to_string(_game_speed)
	data["shadows_enabled"] = _shadows_enabled
	data["window_mode"] = _window_mode_to_string(_window_mode)
	return data


## Loads all relevant global settings.
func load_data() -> void:
	var data: Dictionary = SaveManager.get_data(get_save_id())
	if data.is_empty():
		return

	_master_volume_db = data.get("master_volume_db", 0.0)
	_music_volume_db = data.get("music_volume_db", 0.0)
	_game_volume_db = data.get("game_volume_db", 0.0)
	_game_speed = _string_to_game_speed(data.get("game_speed", "speed_1"))
	_shadows_enabled = data.get("shadows_enabled", true)
	_window_mode = _string_to_window_mode(data.get("window_mode", "windowed"))


## Converts a GameSpeed enum value to a string.
## @param speed The GameSpeed value to convert.
## @return The corresponding string representation.
func _game_speed_to_string(speed: GameSpeed) -> String:
	match speed:
		GameSpeed.SPEED_1:
			return "speed_1"
		GameSpeed.SPEED_2:
			return "speed_2"
		GameSpeed.SPEED_3:
			return "speed_3"
		GameSpeed.SPEED_4:
			return "speed_4"
	return ""  # default return value


## Converts a string representation to a GameSpeed enum value.
## @param speed The string representation to convert.
## @return The corresponding GameSpeed enum value.
func _string_to_game_speed(speed: String) -> GameSpeed:
	match speed:
		"speed_1":
			return GameSpeed.SPEED_1
		"speed_2":
			return GameSpeed.SPEED_2
		"speed_3":
			return GameSpeed.SPEED_3
		"speed_4":
			return GameSpeed.SPEED_4
	return GameSpeed.SPEED_1  # default return value


## Converts a WindowMode enum value to a string.
## @param mode The WindowMode value to convert.
## @return The corresponding string representation.
func _window_mode_to_string(mode: WindowMode) -> String:
	match mode:
		WindowMode.FULL_SCREEN:
			return "fullscreen"
		WindowMode.WINDOWED:
			return "windowed"
		WindowMode.BORDERLESS:
			return "borderless"
	return ""  # default return value


## Converts a string representation to a WindowMode enum value.
## @param mode The string representation to convert.
## @return The corresponding WindowMode enum value.
func _string_to_window_mode(mode: String) -> WindowMode:
	match mode:
		"fullscreen":
			return WindowMode.FULL_SCREEN
		"windowed":
			return WindowMode.WINDOWED
		"borderless":
			return WindowMode.BORDERLESS
	return WindowMode.WINDOWED  # default return value
