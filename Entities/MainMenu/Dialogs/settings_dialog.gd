# =============================================================================
# SettingsDialog.gd
# =============================================================================
# This script defines the behavior of the settings dialog, allowing the user
# to adjust various game settings such as audio volume, game speed,
# shadow settings, and window mode.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name SettingsDialog
extends ModalDialog

## Logger instance for this class.
var _log: Log = Log.new("SettingsDialog")

@onready var _game_container: MarginContainer = %GameContainer
@onready var _video_container: MarginContainer = %VideoContainer
@onready var _graphics_container: MarginContainer = %GraphicsContainer
@onready var _audio_container: MarginContainer = %AudioContainer

@onready var _game_speed_mode_selector: ModeSelector = %GameSpeedModeSelector
@onready var _window_mode_mode_selector: ModeSelector = %WindowModeModeSelector
@onready var _shadow_mode_selector: ModeSelector = %ShadowModeSelector

@onready var _master_volume_slider: VolumeSlider = %MasterVolume
@onready var _music_volume_slider: VolumeSlider = %MusicVolume
@onready var _game_volume_slider: VolumeSlider = %GameVolume


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Connects signals for mode selector and volume slider changes.
	_game_speed_mode_selector.mode_changed.connect(_on_game_speed_mode_changed)
	_window_mode_mode_selector.mode_changed.connect(_on_window_mode_changed)
	_shadow_mode_selector.mode_changed.connect(_on_shadow_mode_changed)

	_master_volume_slider.volume_changed.connect(_on_master_volume_changed)
	_music_volume_slider.volume_changed.connect(_on_music_volume_changed)
	_game_volume_slider.volume_changed.connect(_on_game_volume_changed)

	## Loads the current settings and applies them to the UI.
	_load_current_settings()


## Called when the back button is pressed.
func _on_back_button_pressed() -> void:
	_log.debug("Back Button pressed")
	SaveManager.save_data()
	close(true)


## Loads the current settings and applies them to the UI.
func _load_current_settings() -> void:
	_game_speed_mode_selector.set_selected_mode(Globals._game_speed_to_string(Globals._game_speed))
	_window_mode_mode_selector.set_selected_mode(Globals._window_mode_to_string(Globals._window_mode))
	_shadow_mode_selector.set_selected_mode("on" if Globals._shadows_enabled else "off")

	_master_volume_slider.set_value(Globals._master_volume_db)
	_music_volume_slider.set_value(Globals._music_volume_db)
	_game_volume_slider.set_value(Globals._game_volume_db)


## Called when the game button is pressed.
func _on_game_button_pressed() -> void:
	_game_container.show()
	_video_container.hide()
	_graphics_container.hide()
	_audio_container.hide()


## Called when the video button is pressed.
func _on_video_button_pressed() -> void:
	_game_container.hide()
	_video_container.show()
	_graphics_container.hide()
	_audio_container.hide()


## Called when the audio button is pressed.
func _on_audio_button_pressed() -> void:
	_game_container.hide()
	_video_container.hide()
	_graphics_container.hide()
	_audio_container.show()


## Called when the graphics button is pressed.
func _on_graphics_button_pressed() -> void:
	_game_container.hide()
	_video_container.hide()
	_graphics_container.show()
	_audio_container.hide()


## Called when the game speed mode is changed.
## @param mode The new selected mode.
func _on_game_speed_mode_changed(mode: Mode) -> void:
	_log.debug("Game Speed Mode Changed: " + mode.get_display_text())
	Globals.set_game_speed(Globals._string_to_game_speed(mode.get_id()))


## Called when the window mode is changed.
## @param mode The new selected mode.
func _on_window_mode_changed(mode: Mode) -> void:
	_log.debug("Window Mode Mode Changed: " + mode.get_display_text())
	Globals.set_window_mode(Globals._string_to_window_mode(mode.get_id()))


## Called when the shadow mode is changed.
## @param mode The new selected mode.
func _on_shadow_mode_changed(mode: Mode) -> void:
	_log.debug("Shadow Mode Mode Changed: " + mode.get_display_text())
	Globals.set_shadows_enabled(mode.get_id() == "on")


## Called when the master volume is changed.
## @param value The new master volume value.
func _on_master_volume_changed(value: float) -> void:
	_log.debug("Master Volume Changed: " + str(value))
	Globals.set_master_volume_db(value)


## Called when the music volume is changed.
## @param value The new music volume value.
func _on_music_volume_changed(value: float) -> void:
	_log.debug("Music Volume Changed: " + str(value))
	Globals.set_music_volume_db(value)


## Called when the game volume is changed.
## @param value The new game volume value.
func _on_game_volume_changed(value: float) -> void:
	_log.debug("Game Volume Changed: " + str(value))
	Globals.set_game_volume_db(value)
