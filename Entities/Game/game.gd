extends CanvasLayer

var _game_controller: GameController


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_game_controller = GameController.new()
