class_name GameSetupDialog
extends ModalDialog


func _on_back_button_pressed() -> void:
	close(true)


func _on_play_button_pressed() -> void:
	close(true)
	Events.scene_change_requested.emit(Constants.GAME_SCENE_PATH)
