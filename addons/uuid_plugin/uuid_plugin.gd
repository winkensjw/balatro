@tool
extends EditorPlugin

func _input(event: InputEvent) -> void:
	var input_event : InputEventKey = InputEventKey.new()
	input_event.keycode = Key.KEY_U
	input_event.alt_pressed = true
	input_event.ctrl_pressed = true
	input_event.pressed = false # match on release
	var shortcut : Shortcut = Shortcut.new()
	shortcut.events.append(input_event)
	if event.is_match(input_event) and event.is_released():
		_on_insert_uuid_command()

func _enter_tree() -> void:
	EditorInterface.get_command_palette().add_command("Insert UUID", "insert/uuid", _on_insert_uuid_command, "Ctrl+Shift+U")

func _exit_tree() -> void:
	EditorInterface.get_command_palette().remove_command("insert/uuid")

func generate_uuid() -> String:
	return UUID.v7()

func _on_insert_uuid_command():
	print("Called")
	_get_editior().insert_text_at_caret(generate_uuid())

func _get_editior() -> TextEdit:
	return get_editor_interface().get_script_editor().get_current_editor().get_base_editor()
