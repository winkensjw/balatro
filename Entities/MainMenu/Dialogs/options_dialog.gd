# Options Dialog
class_name OptionsDialog
extends PanelContainer

@onready var settings_dialog_scene: PackedScene = preload(Constants.SETTINGS_DIALOG_SCENE_PATH)


func _on_back_button_pressed() -> void:
	Log.info("Back Button pressed!")
	# FIXME save data
	queue_free()


func _on_credits_button_pressed() -> void:
	Log.info("Credits Button pressed!")


func _on_stats_button_pressed() -> void:
	Log.info("Stats Button pressed!")


func _on_settings_button_pressed() -> void:
	Log.info("Settings Button pressed!")
	var settings_dialog: SettingsDialog = settings_dialog_scene.instantiate()
	add_child(settings_dialog)
