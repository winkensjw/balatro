# Settings Dialog
class_name SettingsDialog
extends PanelContainer

@onready var game_container: MarginContainer = %GameContainer
@onready var video_container: MarginContainer = %VideoContainer
@onready var graphics_container: MarginContainer = %GraphicsContainer
@onready var audio_container: MarginContainer = %AudioContainer

@onready var game_speed_mode_selector: ModeSelector = %GameSpeedModeSelector
@onready var window_mode_mode_selector: ModeSelector = %WindowModeModeSelector
@onready var shadow_mode_selector: ModeSelector = %ShadowModeSelector

@onready var master_volume_slider: VolumeSlider = %MasterVolume
@onready var music_volume_slider: VolumeSlider = %MusicVolume
@onready var game_volume_slider: VolumeSlider = %GameVolume


func _ready() -> void:
	# connect to value changed signals of each mode selector
	game_speed_mode_selector.mode_changed.connect(_on_game_speed_mode_changed)
	window_mode_mode_selector.mode_changed.connect(_on_window_mode_mode_changed)
	shadow_mode_selector.mode_changed.connect(_on_shadow_mode_mode_changed)

	master_volume_slider.volume_changed.connect(_on_master_volume_changed)
	music_volume_slider.volume_changed.connect(_on_music_volume_changed)
	game_volume_slider.volume_changed.connect(_on_game_volume_changed)

	_load_current_settings()


func _load_current_settings() -> void:
	game_speed_mode_selector.set_selected_mode(Globals._game_speed_to_string(Globals.game_speed))
	window_mode_mode_selector.set_selected_mode(Globals._window_mode_to_string(Globals.window_mode))
	shadow_mode_selector.set_selected_mode("on" if Globals.shadows_enabled else "off")

	master_volume_slider.set_value(Globals.master_volume_db)
	music_volume_slider.set_value(Globals.music_volume_db)
	game_volume_slider.set_value(Globals.game_volume_db)


func _on_back_button_pressed() -> void:
	Log.debug("Back Button pressed!")
	SaveManager.save_data()
	queue_free()


func _on_game_button_pressed() -> void:
	game_container.show()
	video_container.hide()
	graphics_container.hide()
	audio_container.hide()


func _on_video_button_pressed() -> void:
	game_container.hide()
	video_container.show()
	graphics_container.hide()
	audio_container.hide()


func _on_audio_button_pressed() -> void:
	game_container.hide()
	video_container.hide()
	graphics_container.hide()
	audio_container.show()


func _on_graphics_button_pressed() -> void:
	game_container.hide()
	video_container.hide()
	graphics_container.show()
	audio_container.hide()


func _on_game_speed_mode_changed(mode: Mode) -> void:
	Log.debug("Game Speed Mode Changed: " + mode.get_display_text())
	Globals.set_game_speed(Globals._string_to_game_speed(mode.get_id()))


func _on_window_mode_mode_changed(mode: Mode) -> void:
	Log.debug("Window Mode Mode Changed: " + mode.get_display_text())
	Globals.set_window_mode(Globals._string_to_window_mode(mode.get_id()))


func _on_shadow_mode_mode_changed(mode: Mode) -> void:
	Log.debug("Shadow Mode Mode Changed: " + mode.get_display_text())
	Globals.set_shadows_enabled(mode.get_id() == "on")


func _on_master_volume_changed(value: float) -> void:
	Log.debug("Master Volume Changed: " + str(value))
	Globals.set_master_volume_db(value)


func _on_music_volume_changed(value: float) -> void:
	Log.debug("Music Volume Changed: " + str(value))
	Globals.set_music_volume_db(value)


func _on_game_volume_changed(value: float) -> void:
	Log.debug("Game Volume Changed: " + str(value))
	Globals.set_game_volume_db(value)
