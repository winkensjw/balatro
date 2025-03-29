# =============================================================================
# RoundInfoContainer.gd
# =============================================================================
# This script defines a PanelContainer that encapsulates the current round info
# and provides access to in-game menus, such as options.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name RoundInfoContainer
extends PanelContainer

var _log: Log = Log.new("RoundInfoContainer")

@onready var _options_dialog_scene: PackedScene = preload(Constants.OPTIONS_DIALOG_SCENE_PATH)

@onready var _hands_amount_label: Label = %HandsAmountLabel
@onready var _discards_amount_label: Label = %DiscardsAmountLabel
@onready var _money_amount_label: Label = %MoneyAmountLabel
@onready var _ante_amount_label: Label = %AnteAmountLabel
@onready var _ante_target_label: Label = %AnteTargetLabel
@onready var _rounds_amount_label: Label = %RoundsAmountLabel


func _ready() -> void:
	Events.hands_changed.connect(_on_hands_changed)
	Events.discards_changed.connect(_on_discards_changed)
	Events.money_changed.connect(_on_money_changed)
	Events.ante_changed.connect(_on_ante_changed)
	Events.round_changed.connect(_on_round_changed)


## Called when the options button is pressed.
func _on_options_button_pressed() -> void:
	_log.debug("Options button pressed")
	Events.show_dialog.emit(_options_dialog_scene, true)


## Called when the run info button is pressed.
func _on_run_info_button_pressed() -> void:
	_log.debug("Run info button pressed")
	Events.show_dialog.emit(_options_dialog_scene, true)


## Called when the amound of hands changed
## @param new_amount: int the new amount of hands
func _on_hands_changed(new_amount: int) -> void:
	_hands_amount_label.text = str(new_amount)


## Called when the amount of discards changed
## @param new_amount: int the new amount of cards available
func _on_discards_changed(new_amount: int) -> void:
	_discards_amount_label.text = str(new_amount)


## Called when the amount of money changed
## @param new_amount: int the new amount of money available to the player
func _on_money_changed(new_amount: int) -> void:
	_money_amount_label.text = str(new_amount)


## Called when the ante changes
## @param new_ante_amount: int the new ante value
## @param new_target_amount: int the new target value for that ante
func _on_ante_changed(new_ante_amount: int, new_target_amount: int) -> void:
	_ante_amount_label.text = str(new_ante_amount)
	_ante_target_label.text = str(new_target_amount)


## Called when the round changes
## @param new_round: int the new round value
func _on_round_changed(new_round: int) -> void:
	_rounds_amount_label.text = str(new_round)
