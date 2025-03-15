# =============================================================================
# ModeSelector.gd
# =============================================================================
# This script defines a custom control that allows the user to select from
# a list of modes. It provides "previous" and "next" buttons to cycle through
# the available modes, and displays the currently selected mode's text.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name ModeSelector
extends Control

## Signal emitted when the selected mode changes.
## @param mode The new selected mode.
signal mode_changed(mode: Mode)

## An array of Mode resources that this selector can cycle through.
@export var _available_modes: Array[Mode] = []

## A reference to the Label node that displays the current mode's text.
@onready var _value_label: Label = $ModeSelectorHbox/ValuePanelContainer/ValueLabel

## The index of the currently selected mode in the _available_modes array.
@onready var _current_index: int = 0


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Updates the displayed text to show the initial mode.
	_update_text()


## Called when the previous button is pressed.
## Cycles to the previous mode in the list.
func _on_previous_button_pressed() -> void:
	if _current_index == 0:
		_current_index = _available_modes.size() - 1
	else:
		_current_index -= 1
	_update_text()
	mode_changed.emit(get_value())


## Called when the next button is pressed.
## Cycles to the next mode in the list.
func _on_next_button_pressed() -> void:
	if _current_index == _available_modes.size() - 1:
		_current_index = 0
	else:
		_current_index += 1
	_update_text()
	mode_changed.emit(get_value())


## Updates the displayed text to show the current mode.
func _update_text() -> void:
	_value_label.text = get_value().get_display_text()


## Gets the currently selected mode.
## @return The Mode resource that is currently selected.
func get_value() -> Mode:
	return _available_modes[_current_index]


## Sets the selected mode by its ID.
## @param mode_id The ID of the mode to select.
func set_selected_mode(mode_id: String) -> void:
	for i in range(_available_modes.size()):
		if _available_modes[i].get_id() == mode_id:
			_current_index = i
			_update_text()
			return
