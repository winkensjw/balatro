# =============================================================================
# Log
# =============================================================================
# This script provides a logging mechanism.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name Log
extends RefCounted

var m_class_name: String


## Constructor that takes a string class_name and stores it in m_class_name.
func _init(name: String) -> void:
	m_class_name = name


## Getter for m_class_name. No setter is provided.
func get_class_name() -> String:
	return m_class_name


## Logs an error message with the given text.
## @param text The text to log as an error.
func error(text: Variant) -> void:
	ConsoleAdapter.error("[" + get_class_name() + "] " + str(text))


## Logs an info message with the given text.
## @param text The text to log as an info.
func info(text: Variant) -> void:
	ConsoleAdapter.info("[" + get_class_name() + "] " + str(text))


## Logs a warning message with the given text.
## @param text The text to log as a warning.
func warn(text: Variant) -> void:
	ConsoleAdapter.warning("[" + get_class_name() + "] " + str(text))


## Logs a debug message with the given text.
## @param text The text to log as a debug message.
func debug(text: Variant) -> void:
	ConsoleAdapter.debug("[" + get_class_name() + "] " + str(text))
