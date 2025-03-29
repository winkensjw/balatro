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

enum Phase { CHOOSE_BLIND, SHOP, PLAY_ROUND }

var _log: Log = Log.new("GameStatePanel")
var _current_container: Control

@onready var _choose_blind_container_scene: PackedScene = preload(Constants.CHOOSE_BLIND_CONTAINER_SCENE_PATH)
@onready var _current_blind_container_scene: PackedScene = preload(Constants.CURRENT_BLIND_CONTAINER_SCENE_PATH)
@onready var _shop_sign_container_scene: PackedScene = preload(Constants.SHOP_SIGN_CONTAINER_SCENE_PATH)

@onready var _box_anchor: Control = %BoxAnchor


func _ready() -> void:
	Events.phase_changed.connect(_on_phase_changed)
	Console.add_command("change_phase", _change_to_shop)
	_add_initial_panel.call_deferred()


func _add_initial_panel() -> void:
	var choose_blind_container: Control = _add_panel(_choose_blind_container_scene)
	choose_blind_container.global_position.x = _box_anchor.global_position.x
	choose_blind_container.global_position.y = _box_anchor.global_position.y


func _add_panel(panel_scene: PackedScene) -> Control:
	var panel: Control = panel_scene.instantiate()
	_current_container = panel
	add_child(panel)
	return panel


func _change_to_shop() -> void:
	_on_phase_changed(Phase.SHOP)


func _on_phase_changed(new_phase: Phase) -> void:
	match new_phase:
		Phase.CHOOSE_BLIND:
			_log.debug("Phase changed to ChooseBlind")
			switch_panel(_current_container, _choose_blind_container_scene)
		Phase.SHOP:
			_log.debug("Phase changed to Shop")
			switch_panel(_current_container, _shop_sign_container_scene)
		Phase.PLAY_ROUND:
			_log.debug("Phase changed to PlayRound")
			switch_panel(_current_container, _current_blind_container_scene)
		_:
			_log.warn("Unknown phase: %s" % new_phase)


## Switches one panel out for the next panel
## @param old_panel: Control The control that will dissapear
## @param new_panel: Control The control that will be displayed
func switch_panel(old_panel: Control, new_panel_scene: PackedScene) -> void:
	var move_distance_up: float = -old_panel.size.y - 10

	var new_panel: Control = _add_panel(new_panel_scene)
	new_panel.global_position.x = _box_anchor.global_position.x
	new_panel.global_position.y = move_distance_up

	var tween: Tween = create_tween()
	tween.tween_property(old_panel, "global_position:y", move_distance_up, 0.3).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.1)
	tween.tween_property(new_panel, "global_position:y", _box_anchor.global_position.y, 0.3).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void: old_panel.queue_free())
