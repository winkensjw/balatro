## ============================================================================
## GameController.gd
## ============================================================================
## Manages the overall game flow and state transitions between different phases,
## such as choosing a blind, shopping, and playing a round.  This class is
## responsible for emitting the `phase_changed` signal to inform other parts of
## the game of state transitions.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name GameController
extends Node

enum Suit { SPADES, HEARTS, CLUBS, DIAMONDS }
enum Rank { TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, J, Q, K, A }

var _log: Log = Log.new("GameController")

var _current_phase: Phase

var _current_score: int = 0

var _current_hands_amount: int = 0
var _max_hands_amount: int = 0

var _current_discards_amount: int = 0
var _max_discards_amount: int = 0

var _current_money: int = 0
var _minimum_money: int = 0

var _current_ante: int = 0
var _ante_target: int = 0

var _current_round: int = 0

var _deck: Deck
var _hand: Array[Card]
var _max_hand_size: int = 0


static func suit_to_string(suit: GameController.Suit) -> String:
	match suit:
		GameController.Suit.SPADES:
			return "Spades"
		GameController.Suit.HEARTS:
			return "Hearts"
		GameController.Suit.CLUBS:
			return "Clubs"
		GameController.Suit.DIAMONDS:
			return "Diamonds"
		_:
			ConsoleAdapter.error("Invalid suit enum: %s" % suit)
			return "unknown"  # Default


static func rank_to_string(rank: GameController.Rank) -> String:
	match rank:
		GameController.Rank.TWO:
			return "2"
		GameController.Rank.THREE:
			return "3"
		GameController.Rank.FOUR:
			return "4"
		GameController.Rank.FIVE:
			return "5"
		GameController.Rank.SIX:
			return "6"
		GameController.Rank.SEVEN:
			return "7"
		GameController.Rank.EIGHT:
			return "8"
		GameController.Rank.NINE:
			return "9"
		GameController.Rank.TEN:
			return "10"
		GameController.Rank.J:
			return "J"
		GameController.Rank.Q:
			return "Q"
		GameController.Rank.K:
			return "K"
		GameController.Rank.A:
			return "A"
		_:
			ConsoleAdapter.error("Invalid rank enum: %s" % rank)
			return "unknown"  # Default


func _init(game_setup: GameSetup) -> void:
	_log.debug("GameController is initializing.")
	ConsoleAdapter.add_command("show_state", func() -> void: ConsoleAdapter.info(_to_string()))
	ConsoleAdapter.add_command("advance_phase", _advance_phase)
	ConsoleAdapter.add_command("draw_hand", draw_hand)
	ConsoleAdapter.add_command("set_current_score", set_current_score, ["score"], 1, "Sets the current score.")
	ConsoleAdapter.add_command("set_current_hands", set_current_hands_amount, ["hands"], 1, "Sets the current hands amount.")
	ConsoleAdapter.add_command("set_max_hands", set_max_hands_amount, ["max_hands"], 1, "Sets the maximum hands amount.")
	ConsoleAdapter.add_command("set_current_discards", set_current_discards_amount, ["discards"], 1, "Sets the current discards amount.")
	ConsoleAdapter.add_command("set_max_discards", set_max_discards_amount, ["max_discards"], 1, "Sets the maximum discards amount.")
	ConsoleAdapter.add_command("set_current_money", set_current_money, ["money"], 1, "Sets the current money amount.")
	ConsoleAdapter.add_command("set_min_money", set_minimum_money, ["min_money"], 1, "Sets the minimum money amount.")
	ConsoleAdapter.add_command("set_current_ante", set_current_ante, ["ante"], 1, "Sets the current ante amount.")
	ConsoleAdapter.add_command("set_ante_target", set_ante_target, ["target"], 1, "Sets the ante target amount.")
	ConsoleAdapter.add_command("set_current_round", set_current_round, ["round"], 1, "Sets the current round number.")

	# Initialize game state from GameSetup
	_max_hands_amount = game_setup.get_max_hands_amount()
	_max_discards_amount = game_setup.get_max_discards_amount()
	_current_money = game_setup.get_money()
	_current_ante = game_setup.get_ante()
	_ante_target = game_setup.get_ante_target()
	_current_round = game_setup.get_round()
	_max_hand_size = game_setup.get_max_hand_size()
	_deck = Deck.new(game_setup.get_deck())
	_hand = []

	_log.debug("GameController is ready. Starting game.")
	start_game()


## Returns the current score.
func get_current_score() -> int:
	return _current_score


## Sets the current score and emits the round_score_changed signal.
## @param new_score: int The new score.
func set_current_score(new_score: int) -> void:
	var score: int = max(new_score, 0)

	if new_score != score:
		_log.warn("Score %s is below minimum 0. Clamping to 0." % new_score)

	if _current_score == score:
		return

	_current_score = score
	Events.round_score_changed.emit(_current_score)


## Returns the current amount of hands.
func get_current_hands_amount() -> int:
	return _current_hands_amount


## Sets the current amount of hands and emits the hands_changed signal.
## @param new_amount: int The new amount of hands.
func set_current_hands_amount(new_amount: int) -> void:
	var amount: int = clamp(new_amount, 1, _max_hands_amount)

	if new_amount != amount:
		_log.warn("Hands amount %s is out of range [1, %s]. Clamping to %s." % [new_amount, _max_hands_amount, amount])

	if _current_hands_amount == amount:
		return

	_current_hands_amount = amount
	Events.hands_changed.emit(_current_hands_amount)


## Returns the max amount of hands
func get_max_hands_amount() -> int:
	return _max_hands_amount


## Sets the max amount of hands
func set_max_hands_amount(new_amount: int) -> void:
	_max_hands_amount = new_amount


## Returns the current amount of discards.
func get_current_discards_amount() -> int:
	return _current_discards_amount


## Sets the current amount of discards and emits the discards_changed signal.
## @param new_amount: int The new amount of discards.
func set_current_discards_amount(new_amount: int) -> void:
	var amount: int = clamp(new_amount, 0, _max_discards_amount)

	if new_amount != amount:
		_log.warn("Discards amount %s is out of range [0, %s]. Clamping to %s." % [new_amount, _max_discards_amount, amount])

	if _current_discards_amount == amount:
		return

	_current_discards_amount = amount
	Events.discards_changed.emit(_current_discards_amount)


## Returns the max amount of discards
func get_max_discards_amount() -> int:
	return _max_discards_amount


## Sets the max amount of discards
func set_max_discards_amount(new_amount: int) -> void:
	_max_discards_amount = new_amount


## Returns the current amount of money.
func get_current_money() -> int:
	return _current_money


## Sets the current amount of money and emits the money_changed signal.
## @param new_amount: int The new amount of money.
func set_current_money(new_amount: int) -> void:
	var amount: int = max(new_amount, _minimum_money)

	if new_amount != amount:
		_log.warn("Money amount %s is below minimum %s. Clamping to %s." % [new_amount, _minimum_money, amount])

	if _current_money == amount:
		return

	_current_money = amount
	Events.money_changed.emit(_current_money)


## Gets the minimum amount of money.
func get_minimum_money() -> int:
	return _minimum_money


## Sets the minimum amount of money
func set_minimum_money(new_amount: int) -> void:
	_minimum_money = new_amount


## Returns the current ante amount.
func get_current_ante() -> int:
	return _current_ante


## Returns the ante target amount
func get_ante_target() -> int:
	return _ante_target


## Sets the current ante amount and emits the ante_changed signal.
## @param new_amount: int The new ante amount.
func set_current_ante(new_amount: int) -> void:
	var amount: int = clamp(new_amount, 1, _ante_target)

	if new_amount != amount:
		_log.warn("Current ante amount %s is out of range [1, %s]. Clamping to %s." % [new_amount, _ante_target, amount])

	if _current_ante == amount:
		return

	_current_ante = amount
	Events.ante_changed.emit(_current_ante, _ante_target)


## Sets the ante target amount
## @param new target: int The new target amount
func set_ante_target(new_target: int) -> void:
	if _ante_target == new_target:
		return

	_ante_target = new_target
	Events.ante_changed.emit(_current_ante, _ante_target)


## Returns the current round.
func get_current_round() -> int:
	return _current_round


## Sets the current round and emits the round_changed signal.
## @param new_round: int The new round number.
func set_current_round(new_round: int) -> void:
	if _current_round == new_round:
		return

	_current_round = new_round
	Events.round_changed.emit(_current_round)


## Returns the deck.
func get_deck() -> Deck:
	return _deck


## Sets the deck.
## @param value: Deck The new deck value.
func set_deck(value: Deck) -> void:
	_deck = value


## Returns the hand.
func get_hand() -> Array[Card]:
	return _hand


## Sets the hand.
## @param value: Array[Card] The new hand value.
func set_hand(value: Array[Card]) -> void:
	_hand = value


## Returns the max hand size.
func get_max_hand_size() -> int:
	return _max_hand_size


## Sets the max hand size.
## @param value: int The new max hand size value.
func set_max_hand_size(value: int) -> void:
	_max_hand_size = value


## Starts the game by setting the initial phase.
func start_game() -> void:
	_set_phase(ChooseBlindPhase.new(self))


## Sets the current game phase and emits the phase_changed signal.
## @param new_phase: Phase The new game phase to set.
func _set_phase(new_phase: Phase) -> void:
	if _current_phase == new_phase:
		_log.debug("Phase already set to: %s" % new_phase)
		return

	_log.debug("Changing phase from %s to %s" % [_current_phase, new_phase])
	if _current_phase != null:
		_current_phase.exit()
	_current_phase = new_phase
	_current_phase.enter()
	Events.phase_changed.emit(_current_phase)


## Advances the game to the next phase based on the current phase.
func _advance_phase() -> void:
	match _current_phase._phase:
		Phase.PhaseType.CHOOSE_BLIND:
			_set_phase(PlayRoundPhase.new(self))
		Phase.PhaseType.PLAY_ROUND:
			_set_phase(CalcResultPhase.new(self))
		Phase.PhaseType.CALC_RESULTS:
			_set_phase(ShopPhase.new(self))
		Phase.PhaseType.SHOP:
			_set_phase(ChooseBlindPhase.new(self))
		_:
			_log.warn("Unknown phase: %s" % _current_phase)


func draw_hand() -> void:
	while _hand.size() < _max_hand_size:
		_hand.append(_deck.draw_card())


## Returns a string representation of the GameController.
func _to_string() -> String:
	var hand_string: String = "["
	for card in _hand:
		hand_string += str(card) + ", "
	if _hand.size() > 0:
		hand_string = hand_string.substr(0, hand_string.length() - 2)  # Remove trailing ", "
	hand_string += "]"

	return (
		"[GameController: Phase=%s, Score=%s, Hands=%s/%s, Discards=%s/%s, Money=%s, Ante=%s/%s, Round=%s, MaxHandSize=%s, Deck=%s, Hand=%s]"
		% [_current_phase, _current_score, _current_hands_amount, _max_hands_amount, _current_discards_amount, _max_discards_amount, _current_money, _current_ante, _ante_target, _current_round, _max_hand_size, _deck, hand_string]
	)
