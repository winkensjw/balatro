# Settings Dialog
class_name SettingsDialog
extends PanelContainer

@onready var game_container: MarginContainer = %GameContainer
@onready var video_container: MarginContainer = %VideoContainer
@onready var graphics_container: MarginContainer = %GraphicsContainer
@onready var audio_container: MarginContainer = %AudioContainer


func _on_back_button_pressed() -> void:
	Log.info("Back Button pressed!")
	# FIXME save data
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
