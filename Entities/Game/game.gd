extends CanvasLayer

var _game_setup: GameSetup
var _game_controller: GameController


func receive_transition_data(game_setup: GameSetup) -> void:
	_game_setup = game_setup


func _ready() -> void:
	_create_game_controller.call_deferred()  # call when the whole scene is ready


func _create_game_controller() -> void:
	_game_controller = GameController.new(_game_setup)
