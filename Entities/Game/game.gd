extends CanvasLayer

var _game_controller: GameController


func receive_transition_data(game_setup: GameSetup) -> void:
	_game_controller = GameController.new(game_setup)
