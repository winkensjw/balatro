extends Node

func error(text : Variant) -> void:
	ConsoleAdapter.error(text)

func info(text : Variant) -> void:
	ConsoleAdapter.info(text)
	
func warn(text : Variant) -> void:
	ConsoleAdapter.warning(text)
