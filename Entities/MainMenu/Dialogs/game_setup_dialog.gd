class_name GameSetupDialog
extends ModalDialog


func _on_back_button_pressed() -> void:
	close(true)


func _on_play_button_pressed() -> void:
	close(true)
	Events.change_current_scene.emit(Constants.GAME_SCENE_PATH)
