# =============================================================================
# GameStatePanel.gd
# =============================================================================
# This script defines a PanelContainer that encapsulates the current game state
# and provides access to in-game menus, such as options.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name GameStatePanel
extends Control

var _log: Log = Log.new("GameStatePanel")
var _current_container: Control
var _offscreen_position: Vector2

@onready var _choose_blind_container_scene: PackedScene = preload(Constants.CHOOSE_BLIND_CONTAINER_SCENE_PATH)
@onready var _current_blind_container_scene: PackedScene = preload(Constants.CURRENT_BLIND_CONTAINER_SCENE_PATH)
@onready var _shop_sign_container_scene: PackedScene = preload(Constants.SHOP_SIGN_CONTAINER_SCENE_PATH)

@onready var _box_anchor: Control = %BoxAnchor


func _ready() -> void:
	Events.phase_changed.connect(_on_phase_changed)
	_offscreen_position = Vector2(_box_anchor.global_position.x, -_box_anchor.size.y - 10)
	_compute_offscreen_position.call_deferred()
	_add_initial_panel.call_deferred()


func _compute_offscreen_position() -> void:
	_offscreen_position = Vector2(_box_anchor.global_position.x, -_box_anchor.size.y - 10)


func _add_initial_panel() -> void:
	_add_panel(_choose_blind_container_scene, _box_anchor.global_position)


func _add_panel(container_scene: PackedScene, initial_position: Vector2 = _offscreen_position) -> Control:
	var container: Control = container_scene.instantiate()
	_current_container = container
	add_child(container)
	container.global_position = initial_position
	return container


func _on_phase_changed(new_phase: GameController.Phase) -> void:
	var old_container: Control = _current_container
	match new_phase:
		GameController.Phase.CHOOSE_BLIND:
			_log.debug("Phase changed to ChooseBlind")
			var new_container: Control = _add_panel(_choose_blind_container_scene)
			switch_panel(old_container, new_container)
		GameController.Phase.PLAY_ROUND:
			_log.debug("Phase changed to PlayRound")
			var new_container: Control = _add_panel(_current_blind_container_scene)
			switch_panel(old_container, new_container)
		GameController.Phase.SHOP:
			_log.debug("Phase changed to Shop")
			var new_container: Control = _add_panel(_shop_sign_container_scene)
			switch_panel(old_container, new_container)
		GameController.Phase.CALC_RESULTS:
			_log.debug("Phase changed to CalcResults")
			_log.warn("Phase not supported yet.")
		_:
			_log.warn("Unknown phase: %s" % new_phase)


## Switches one panel out for the next panel
## @param old_panel: Control The control that will dissapear
## @param new_panel: Control The control that will be displayed
func switch_panel(old_panel: Control, new_panel: Control) -> void:
	# off screen position for the old panel
	var move_distance_up: float = -old_panel.size.y - 10

	var tween: Tween = create_tween()
	# move old panel off screen
	tween.tween_property(old_panel, "global_position:y", move_distance_up, 0.3).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.1)
	# move new panel into view
	tween.tween_property(new_panel, "global_position:y", _box_anchor.global_position.y, 0.3).set_ease(Tween.EASE_OUT)
	# remove old panel
	tween.tween_callback(func() -> void: old_panel.queue_free())
