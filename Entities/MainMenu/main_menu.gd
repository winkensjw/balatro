# Main Menu
class_name MainMenu
extends CanvasLayer

@onready var options_dialog_scene: PackedScene = preload(Constants.OPTIONS_DIALOG_SCENE_PATH)


func _ready() -> void:
	MusicManager.play("music", "background_music")


func _on_profile_button_pressed() -> void:
	Log.info("Profile button pressed")


func _on_language_button_pressed() -> void:
	Log.info("Language button pressed")


func _on_collection_button_pressed() -> void:
	Log.info("Collection button pressed")


func _on_quit_button_pressed() -> void:
	Events.quit_game_requested.emit()


func _on_options_button_pressed() -> void:
	Log.info("Options button pressed")
	var options_dialog: OptionsDialog = options_dialog_scene.instantiate()
	add_child(options_dialog)


func _on_play_button_pressed() -> void:
	Log.info("Play button pressed")
