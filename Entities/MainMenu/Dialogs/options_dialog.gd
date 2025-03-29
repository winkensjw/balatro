# =============================================================================
# OptionsDialog.gd
# =============================================================================
# This script defines the behavior of the options dialog, which allows the user
# to access various sub-menus such as settings, credits, and stats.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name OptionsDialog
extends ModalDialog

## Logger instance for this class.
var _log: Log = Log.new("OptionsDialog")

## PackedScene for the Settings Dialog.
@onready var _settings_dialog_scene: PackedScene = preload(Constants.SETTINGS_DIALOG_SCENE_PATH)


## Called when the back button is pressed.
func _on_back_button_pressed() -> void:
	_log.debug("Back Button pressed")
	close(true)


## Called when the credits button is pressed.
func _on_credits_button_pressed() -> void:
	_log.debug("Credits Button pressed")


## Called when the stats button is pressed.
func _on_stats_button_pressed() -> void:
	_log.debug("Stats Button pressed")


## Called when the settings button is pressed.
## Instantiates the settings dialog scene and adds it as a child.
func _on_settings_button_pressed() -> void:
	_log.debug("Settings Button pressed")
	Events.show_dialog.emit(_settings_dialog_scene, true)
