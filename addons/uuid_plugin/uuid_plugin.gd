@tool
extends EditorPlugin

var _short_cut : InputEventKey = _create_shortcut()

func _input(event: InputEvent) -> void:
	if event.is_match(_short_cut) and event.is_released():
		_insert_uuid()

func _create_shortcut():
	var input_event : InputEventKey = InputEventKey.new()
	input_event.keycode = Key.KEY_U
	input_event.alt_pressed = true
	input_event.ctrl_pressed = true
	return input_event
	
func _enter_tree() -> void:
	EditorInterface.get_command_palette().add_command("Insert UUID", "insert/uuid", _insert_uuid, "Ctrl+Alt+U")

func _exit_tree() -> void:
	EditorInterface.get_command_palette().remove_command("insert/uuid")

func _insert_uuid() -> void:
	_get_editior().insert_text_at_caret(_generate_uuid())

func _get_editior() -> TextEdit:
	return get_editor_interface().get_script_editor().get_current_editor().get_base_editor()

func _generate_uuid() -> String:
	return UUID.v7()
