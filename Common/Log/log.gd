extends Node


func error(text: Variant) -> void:
	ConsoleAdapter.error(text)


func info(text: Variant) -> void:
	ConsoleAdapter.info(text)


func warn(text: Variant) -> void:
	ConsoleAdapter.warning(text)


func debug(text: Variant) -> void:
	if not ConsoleAdapter.debug_enabled:
		return  # FIXME add this to the console for good
	ConsoleAdapter.info(text)
