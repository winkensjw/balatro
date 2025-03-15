# =============================================================================
# Mode.gd
# =============================================================================
# This script defines a Resource representing a mode in a ModeSelector.
# It contains a display text and an identifier.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name Mode
extends Resource

## The text to display for this mode in the UI.
@export var _display_text: String = ""

## A unique identifier for this mode.
@export var _id: String = ""


## Checks if this mode is equal to another mode.
## @param other The other mode to compare to.
## @return True if the modes have the same display text and ID, false otherwise.
func equals(other: Mode) -> bool:
	return self._display_text == other._display_text && self._id == other._id


## Gets the display text for this mode.
## @return The display text.
func get_display_text() -> String:
	return _display_text


## Sets the display text for this mode.
## @param value The new display text.
func set_display_text(value: String) -> void:
	_display_text = value


## Gets the ID for this mode.
## @return The ID.
func get_id() -> String:
	return _id


## Sets the ID for this mode.
## @param value The new ID.
func set_id(value: String) -> void:
	_id = value
