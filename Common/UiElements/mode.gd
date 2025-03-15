# Mode
class_name Mode
extends Resource

@export var m_display_text: String = ""
@export var m_id: String = ""


func equals(other: Mode) -> bool:
	return self.m_display_text == other.m_display_text && self.m_id == other.m_id


func get_display_text() -> String:
	return m_display_text


func set_display_text(value: String) -> void:
	m_display_text = value


func get_id() -> String:
	return m_id


func set_id(value: String) -> void:
	m_id = value
