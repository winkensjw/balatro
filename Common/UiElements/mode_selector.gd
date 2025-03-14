# Mode Selector
class_name ModeSelector
extends Control

@export var m_available_modes: Array[Mode] = []
@onready var m_value_label: Label = $ModeSelectorHbox/ValuePanelContainer/ValueLabel
@onready var m_current_index: int = 0


func _ready() -> void:
	_update_text()


func _on_previous_button_pressed() -> void:
	if m_current_index == 0:
		return
	m_current_index -= 1
	_update_text()


func _on_next_button_pressed() -> void:
	if m_current_index == m_available_modes.size() - 1:
		return
	m_current_index += 1
	_update_text()


func _update_text() -> void:
	m_value_label.text = m_available_modes[m_current_index].m_display_text


func get_value() -> Mode:
	return m_available_modes[m_current_index]
