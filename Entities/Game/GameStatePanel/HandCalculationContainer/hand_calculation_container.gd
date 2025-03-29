## ============================================================================
## HandCalculationContainer.gd
## ============================================================================
## Displays the results of the most recent hand calculation, including the hand
## rank, level, chips earned, and multiplier.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name HandCalculationContainer
extends PanelContainer

@onready var _hand_label: Label = %HandLabel
@onready var _hand_level_label: Label = %HandLevelLabel
@onready var _hand_level_amount_label: Label = %HandLevelAmountLabel
@onready var _chips_label: Label = %ChipsLabel
@onready var _mult_label: Label = %MultLabel


func _ready() -> void:
	Events.scored_hand_changed.connect(_on_scored_hand_changed)
	Events.chips_changed.connect(_on_chips_changed)
	Events.mult_changed.connect(_on_mult_changed)


## Called when the scored hand changes.
## @param scored_hand: String The name of the hand rank (e.g., "Pair", "Flush").
## @param score_hand_level: String the level of the hand
func _on_scored_hand_changed(scored_hand: String, score_hand_level: String) -> void:
	_hand_label.visible = true
	_hand_level_label.visible = true
	_hand_level_amount_label.visible = true

	_hand_label.text = scored_hand
	_hand_level_amount_label.text = score_hand_level


## Called when the amount of chips changes.
## @param new_amount: int The new amount of chips.
func _on_chips_changed(new_amount: int) -> void:
	_chips_label.text = str(new_amount)


## Called when the multiplier changes.
## @param new_amount: int The new multiplier amount.
func _on_mult_changed(new_amount: int) -> void:
	_mult_label.text = str(new_amount)
