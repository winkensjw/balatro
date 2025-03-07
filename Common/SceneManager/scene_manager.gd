extends Node

var _loading_screen: LoadingScreen
var _transition: String
var _scene_path: String
var _load_progress_timer: Timer
var _load_scene_into: Node
var _scene_to_unload: Node
var _loading_in_progress: bool = false


func _ready() -> void:
	Events.scene_invalid.connect(_on_scene_invalid)
	Events.scene_failed_to_load.connect(_on_scene_failed_to_load)
	Events.scene_finished_loading.connect(_on_scene_finished_loading)


func _add_loading_screen(transition_type: String = "fade_to_black") -> void:
	_transition = "no_to_transition" if transition_type == "no_transition" else transition_type
	_loading_screen = LoadingScreen.create()
	add_child(_loading_screen)
	_loading_screen.start_transition(_transition)


func change_scenes(scene_to_load: String, load_into: Node = null, scene_to_unload: Node = null, transition_type: String = "fade_to_black") -> void:
	if _loading_in_progress:
		Log.warn("SceneManager is already loading something")
		return

	_loading_in_progress = true
	if load_into == null:
		load_into = get_tree().root
	_load_scene_into = load_into
	_scene_to_unload = scene_to_unload

	_add_loading_screen(transition_type)
	_load_scene(scene_to_load)


func _load_scene(scene_path: String) -> void:
	Events.load_start.emit(_loading_screen)

	_scene_path = scene_path
	var loader: Error = ResourceLoader.load_threaded_request(scene_path)
	if not ResourceLoader.exists(scene_path) or loader == null:
		Events.scene_invalid.emit(scene_path)
		return

	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(_monitor_load_status)

	add_child(_load_progress_timer)
	_load_progress_timer.start()


func _monitor_load_status() -> void:
	var load_progress: Array = []
	var load_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(_scene_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			Events.scene_invalid.emit(_scene_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if _loading_screen != null:
				_loading_screen.update_bar(load_progress[0] * 100)  # 0.1
		ResourceLoader.THREAD_LOAD_FAILED:
			Events.scene_failed_to_load.emit(_scene_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			Events.scene_finished_loading.emit(ResourceLoader.load_threaded_get(_scene_path).instantiate())
			return


func _on_scene_failed_to_load(path: String) -> void:
	Log.error("error: Failed to load resource: '%s'" % [path])


func _on_scene_invalid(path: String) -> void:
	Log.error("error: Cannot load resource: '%s'" % [path])


func _on_scene_finished_loading(incoming_scene: Node) -> void:
	var outgoing_scene: Node = _scene_to_unload

	if outgoing_scene != null:
		if outgoing_scene.has_method("get_data") and incoming_scene.has_method("receive_data"):
			incoming_scene.receive_data(outgoing_scene.get_data())

	_load_scene_into.add_child(incoming_scene)
	Events.scene_added.emit(incoming_scene, _loading_screen)

	if _scene_to_unload != null:
		if _scene_to_unload != get_tree().root:
			_scene_to_unload.queue_free()

	if incoming_scene.has_method("init_scene"):
		incoming_scene.init_scene()

	# probably not necssary since we split our _content_finished_loading but it won't hurt to have an extra check
	if _loading_screen != null:
		_loading_screen.finish_transition()
		await _loading_screen.anim_player.animation_finished

	if incoming_scene.has_method("start_scene"):
		incoming_scene.start_scene()

	# load is complete, free up SceneManager to load something else and report load_complete signal
	_loading_in_progress = false
	Events.load_complete.emit(incoming_scene)
