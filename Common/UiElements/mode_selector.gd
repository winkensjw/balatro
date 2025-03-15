# Mode Selector
class_name ModeSelector
extends Control

signal mode_changed(mode: Mode)

@export var m_available_modes: Array[Mode] = []
@onready var m_value_label: Label = $ModeSelectorHbox/ValuePanelContainer/ValueLabel
@onready var m_current_index: int = 0


func _ready() -> void:
	_update_text()


func _on_previous_button_pressed() -> void:
	if m_current_index == 0:
		m_current_index = m_available_modes.size() - 1
	else:
		m_current_index -= 1
	_update_text()
	mode_changed.emit(get_value())


func _on_next_button_pressed() -> void:
	if m_current_index == m_available_modes.size() - 1:
		m_current_index = 0
	else:
		m_current_index += 1
	_update_text()
	mode_changed.emit(get_value())


func _update_text() -> void:
	m_value_label.text = m_available_modes[m_current_index].m_display_text


func get_value() -> Mode:
	return m_available_modes[m_current_index]


func set_selected_mode(mode_id: String) -> void:
	for i in range(m_available_modes.size()):
		if m_available_modes[i].get_id() == mode_id:
			m_current_index = i
			_update_text()
			return
