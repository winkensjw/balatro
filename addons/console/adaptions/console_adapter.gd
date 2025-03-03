class_name ConsoleAdapter
extends Node

static var print_to_godot = true

static func init() -> void:
	# initialize console here via Console.property
	pass

func add_command(command_name : String, function : Callable, arguments = [], required: int = 0, description : String = "") -> void:
	Console.add_command(command_name, function, arguments, required, description)

func add_hidden_command(command_name : String, function : Callable, arguments = [], required : int = 0) -> void:
	Console.add_hidden_command(command_name, function, arguments, required)

func remove_command(command_name : String) -> void:
	Console.remove_command(command_name)

func add_command_autocomplete_list(command_name : String, param_list : PackedStringArray) -> void:
	Console.add_command_autocomplete_list(command_name, param_list)

static func error(text : Variant) -> void:
	Console.print_error(text, print_to_godot)

static func info(text : Variant) -> void:
	Console.print_info(text, print_to_godot)
	
static func warning(text : Variant) -> void:
	Console.print_warning(text, print_to_godot)
