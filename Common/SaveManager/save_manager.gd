# =============================================================================
# save_manager.gd
# =============================================================================
# This script manages saving and loading game data to persistent storage. It
# collects data from nodes in the "persistable" group, serializes it to JSON,
# and saves/loads it to/from a file.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node

## Location of the save file in the user:// directory.
const SAVE_LOCATION = "user://balatro.save"

## Settings for the save manager.  Loaded from a resource path.
@export var _settings: SaveManagerSettings = preload(Constants.SAVE_MANAGER_SETTINGS_RESOURCE_PATH)

## A dictionary containing the loaded save data.
var _data: Dictionary = {}

## Logger instance for this class.
## Used to output debug messages.
var _log: Log = Log.new("SaveManager")


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Loads the saved data from the file.
	_data = load_data()


## Called when a window close request is received.
## If save_on_close is enabled in the settings, the game data is saved.
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and _settings.save_on_close:
		save_data()


## Saves the game data to a file.
func save_data() -> void:
	## Collects data from persistable nodes and writes it to the save file.
	_write_save_file(_collect_data())


## Loads the game data from a file.
## @return A Dictionary containing the loaded save data, or an empty Dictionary if loading fails or the file doesn't exist.
func load_data() -> Dictionary:
	## Loads the save file and returns its contents as a dictionary.
	return _load_save_file()


## Writes the given data to the save file.
## @param data_dict The dictionary containing the data to save.
func _write_save_file(data_dict: Dictionary) -> void:
	var save_file: FileAccess = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	var json_string: String = JSON.stringify(data_dict)
	save_file.store_line(json_string)


## Loads the save file and parses its contents.
## @return A Dictionary containing the loaded save data, or an empty Dictionary if loading fails or the file doesn't exist.
func _load_save_file() -> Dictionary:
	if not FileAccess.file_exists(SAVE_LOCATION):
		return {}

	var save_file: FileAccess = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	var json_string: String = save_file.get_line()
	var json: JSON = JSON.new()
	var parse_result: Error = json.parse(json_string)
	if not parse_result == OK:
		_log.error(Strings.join("", ["JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line()]))
		return {}
	return json.data


## Collects save data from all nodes in the "persistable" group.
## @return A Dictionary containing the save data for each persistable node, keyed by their save ID.
func _collect_data() -> Dictionary:
	var data_to_save: Dictionary = {}
	for node in get_tree().get_nodes_in_group("persistable"):
		if not _is_persistable(node):
			continue
		var save_id: String = node.get_save_id()
		var node_save_data: Dictionary = node.save_data()
		data_to_save[save_id] = node_save_data
	return data_to_save


## Checks if a node is persistable.
## A node is persistable if it implements save_data, load_data, and get_save_id.
## @param node The node to check.
## @return True if the node is persistable, false otherwise.
func _is_persistable(node: Node) -> bool:
	var persistable: bool = true
	if not node.has_method("save_data"):
		_log.error("Persistable node does not implement save_data!")
		persistable = false
	if not node.has_method("load_data"):
		_log.error("Persistable node does not implement load_data!")
		persistable = false
	if not node.has_method("get_save_id"):
		_log.error("Persistable node does not implement get_save_id!")
		persistable = false
	return persistable


## Gets the save data for a given save ID.
## @param save_id The save ID to retrieve data for.
## @return A Dictionary containing the save data, or an empty Dictionary if the save ID is not found.
func get_data(save_id: String) -> Dictionary:
	return _data.get(save_id, {})
