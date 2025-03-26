class_name GameStatePanel
extends PanelContainer

## Logger instance for this class.
var _log: Log = Log.new(self.name)

## PackedScene for the Options Dialog.
@onready var _options_dialog_scene: PackedScene = preload(Constants.OPTIONS_DIALOG_SCENE_PATH)


## Called when the options button is pressed.
func _on_options_button_pressed() -> void:
	_log.debug("Options button pressed")
	Events.show_dialog.emit(_options_dialog_scene, true)
