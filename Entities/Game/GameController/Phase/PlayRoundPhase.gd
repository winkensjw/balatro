class_name PlayRoundPhase
extends Phase


func _init(game_controller: GameController) -> void:
	super._init(game_controller)
	_phase = PhaseType.PLAY_ROUND


func enter() -> void:
	super.enter()
	_game_controller.reset_hand_count()
	_game_controller.reset_discard_count()
	_game_controller.draw_hand()
