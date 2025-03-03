extends Node

const SAVE_LOCATION = "user://balatro.save"

var settings : SaveManagerSettings = preload(Constants.SAVE_MANAGER_SETTINGS_RESOURCE_PATH)

var data : Dictionary = {}

func _ready() -> void:
	data = load_data()

func _notification(what : int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and settings.save_on_close:
		save_data()

func save_data() -> void:
	_write_save_file(_collect_data())

func load_data() -> Dictionary:
	return _load_save_file()
	
func _write_save_file(data_dict : Dictionary) -> void:
	var save_file : FileAccess = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	var json_string : String = JSON.stringify(data_dict)
	save_file.store_line(json_string)
	
func _load_save_file() -> Dictionary:
	if not FileAccess.file_exists(SAVE_LOCATION):
		return {}
	
	var save_file : FileAccess = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	var json_string : String = save_file.get_line()
	var json : JSON = JSON.new()
	var parse_result : Error = json.parse(json_string)
	if not parse_result == OK:
		Log.error(Strings.join("", ["JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line()]))
		return {}
	return json.data

func _collect_data() -> Dictionary:
	var data_to_save : Dictionary = {}
	for node in get_tree().get_nodes_in_group("persistable"):
		if not _is_persistable(node):
			continue
		var save_id : String = node.get_save_id()
		var node_save_data : Dictionary = node.save_data()
		data_to_save[save_id] = node_save_data
	return data_to_save
		
func _is_persistable(node : Node) -> bool:
	var persistable : bool = true
	if not node.has_method("save_data"):
		Log.error("Persistable node does not implement save_data!")
		persistable = false
	if not node.has_method("load_data"):
		Log.error("Persistable node does not implement load_data!")
		persistable = false
	if not node.has_method("get_save_id"):
		Log.error("Persistable node does not implement get_save_id!")
		persistable = false
	return persistable

func get_data(save_id : String) -> Dictionary:
	return data.get(save_id, {})
