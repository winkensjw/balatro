# Mode
class_name Mode
extends Resource

@export var m_display_text: String = ""


func equals(other: Mode) -> bool:
	return self.m_display_text == other.m_display_text
