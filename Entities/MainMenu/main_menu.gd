extends CanvasLayer


func _ready() -> void:
	MusicManager.play("music", "background_music")


func _on_profile_button_pressed() -> void:
	Log.info("Profile button pressed")


func _on_language_button_pressed() -> void:
	Log.info("Language button pressed")


func _on_collection_button_pressed() -> void:
	Log.info("Collection button pressed")


func _on_quit_button_pressed() -> void:
	Log.info("Quit button pressed")


func _on_options_button_pressed() -> void:
	Log.info("Options button pressed")


func _on_play_button_pressed() -> void:
	Log.info("Play button pressed")
