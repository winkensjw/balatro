## ============================================================================
## RoundScoreContainer.gd
## ============================================================================
## Displays the score accumulated during the current round.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name RoundScoreCountainer
extends PanelContainer

@onready var _round_score_label: Label = %RoundScoreLabel


func _ready() -> void:
	Events.round_score_changed.connect(_on_round_score_changed)


## Called when the round score changes.
## @param new_amount: int The new round score.
func _on_round_score_changed(new_amount: int) -> void:
	_round_score_label.text = str(new_amount)
