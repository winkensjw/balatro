class_name Phase
extends RefCounted

## Enum representing the different phases of the game.
enum PhaseType { CHOOSE_BLIND, PLAY_ROUND, CALC_RESULTS, SHOP }

var _phase: PhaseType
var _game_controller: GameController


static func phase_to_string(phase: PhaseType) -> String:
	match phase:
		PhaseType.CHOOSE_BLIND:
			return "Choose blind"
		PhaseType.PLAY_ROUND:
			return "Play round"
		PhaseType.CALC_RESULTS:
			return "Calc results"
		PhaseType.SHOP:
			return "Shop"
		_:
			ConsoleAdapter.error("Invalid phase enum: %s" % phase)
			return "unknown"  # Default


func _init(game_controller: GameController) -> void:
	_game_controller = game_controller


func enter() -> void:
	ConsoleAdapter.debug("%s state entered" % phase_to_string(_phase))


func exit() -> void:
	ConsoleAdapter.debug("%s state left" % phase_to_string(_phase))


## Returns a string representation of the phase.
func _to_string() -> String:
	return "[Phase: %s]" % phase_to_string(_phase)
