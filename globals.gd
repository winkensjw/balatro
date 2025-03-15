extends Node

enum WindowMode { FULL_SCREEN, WINDOWED, BORDERLESS }
enum GameSpeed { SPEED_1, SPEED_2, SPEED_3, SPEED_4 }

# Save identifiers
const SAVE_ID: String = "f8a7b6c5-d4e3-2f1g-h0i9-j8k7l6m5n4o3"
const VERSION_ID: String = "1"

# Audio volume settings
var master_volume_db: float = 0.0
var music_volume_db: float = 0.0
var game_volume_db: float = 0.0

# Game settings
var game_speed: GameSpeed = GameSpeed.SPEED_1
var shadows_enabled: bool = true

# Window settings
var window_mode: WindowMode = WindowMode.WINDOWED


func _ready() -> void:
	add_to_group("persistable")

	load_data()

	_apply_window_mode()
	_apply_volume_settings()


func set_master_volume_db(value: float) -> void:
	master_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


func set_music_volume_db(value: float) -> void:
	music_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


func set_game_volume_db(value: float) -> void:
	game_volume_db = value
	_apply_volume_settings()
	Events.settings_changed.emit()


func set_game_speed(value: GameSpeed) -> void:
	game_speed = value
	Events.settings_changed.emit()


func set_shadows_enabled(enabled: bool) -> void:
	shadows_enabled = enabled
	Events.settings_changed.emit()


func set_window_mode(mode: WindowMode) -> void:
	window_mode = mode
	_apply_window_mode()
	Events.settings_changed.emit()


func _apply_volume_settings() -> void:
	ResonateAdapter.update_volume()


func _apply_window_mode() -> void:
	match window_mode:
		WindowMode.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		WindowMode.FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		WindowMode.BORDERLESS:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func get_save_id() -> String:
	return SAVE_ID


func save_data() -> Dictionary:
	Log.info("Saving settings")
	var data: Dictionary = {}
	data["version_id"] = VERSION_ID
	data["master_volume_db"] = master_volume_db
	data["music_volume_db"] = music_volume_db
	data["game_volume_db"] = game_volume_db
	data["game_speed"] = _game_speed_to_string(game_speed)
	data["shadows_enabled"] = shadows_enabled
	data["window_mode"] = _window_mode_to_string(window_mode)
	return data


func load_data() -> void:
	var data: Dictionary = SaveManager.get_data(get_save_id())
	if data.is_empty():
		return

	master_volume_db = data.get("master_volume_db", 0.0)
	music_volume_db = data.get("music_volume_db", 0.0)
	game_volume_db = data.get("game_volume_db", 0.0)
	game_speed = _string_to_game_speed(data.get("game_speed", "speed_1"))
	shadows_enabled = data.get("shadows_enabled", true)
	window_mode = _string_to_window_mode(data.get("window_mode", "windowed"))


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


func _window_mode_to_string(mode: WindowMode) -> String:
	match mode:
		WindowMode.FULL_SCREEN:
			return "fullscreen"
		WindowMode.WINDOWED:
			return "windowed"
		WindowMode.BORDERLESS:
			return "borderless"
	return ""  # default return value


func _string_to_window_mode(mode: String) -> WindowMode:
	match mode:
		"fullscreen":
			return WindowMode.FULL_SCREEN
		"windowed":
			return WindowMode.WINDOWED
		"borderless":
			return WindowMode.BORDERLESS
	return WindowMode.WINDOWED  # default return value
