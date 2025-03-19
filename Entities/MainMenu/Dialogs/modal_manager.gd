# =============================================================================
# ModalManager.gd
# =============================================================================
# This script manages the creation and display of modal dialogs.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name ModalManager
extends Node

## The amount to offset the dialog offscreen during the closing animation.
const OFFSCREEN_OFFSET := 100

## Stack of modal layers.
var _modal_layers: Array[ModalLayer] = []


## Inner class representing a modal layer.
class ModalLayer:
	extends CanvasLayer

	var click_blocker: Panel

	func _init() -> void:
		layer = 100  #Starting Layer

		click_blocker = Panel.new()
		click_blocker.set_anchors_preset(Control.LayoutPreset.PRESET_FULL_RECT)
		click_blocker.mouse_filter = Control.MOUSE_FILTER_STOP  # Block all mouse input
		add_child(click_blocker)

	func set_transparent() -> void:
		var style: StyleBoxFlat = StyleBoxFlat.new()
		style.bg_color = Color(0, 0, 0, 0)
		click_blocker.add_theme_stylebox_override("panel", style)

	func set_opaque() -> void:
		var style: StyleBoxFlat = StyleBoxFlat.new()
		style.bg_color = Color(0, 0, 0, 0.5)
		click_blocker.add_theme_stylebox_override("panel", style)


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Connects the signals to show and close the respective dialogs.
	Events.show_dialog.connect(_show_dialog)
	Events.close_dialog.connect(_close_dialog)


## Helper function to show a dialog with optional animation
func _show_dialog(dialog_scene: PackedScene, animate: bool) -> void:
	# Uses the create function in the ModalLayer
	var modal_layer: ModalLayer = ModalLayer.new()

	# Creates modal Layer for object on screen.
	if not _modal_layers.is_empty():
		modal_layer.layer = _modal_layers.back().layer + 1
		modal_layer.set_transparent()  # Make higher layers transparent
	else:
		modal_layer.set_opaque()  # Make it opaque if its the first layer in the stack

	get_tree().root.add_child(modal_layer)

	# Load current list
	var dialog: Control = dialog_scene.instantiate()
	modal_layer.add_child(dialog)  #Puts object in scene.

	# Move dialog to the middle of screen
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	dialog.position = viewport_size / 2 - dialog.size / 2

	if animate:
		# Move offscreen and then animates the dialog to the middle of screen
		dialog.position.y = viewport_size.y
		var tween: Tween = create_tween()
		tween.tween_property(dialog, "position:y", (viewport_size / 2 - dialog.size / 2).y, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		#await to avoid double loading.

	# Add modal layer to stack
	_modal_layers.append(modal_layer)


## Helper function to close a dialog with optional animation
func _close_dialog(dialog: Control, animate: bool) -> void:
	var modal_layer: ModalLayer = _modal_layers.pop_back()
	modal_layer.set_transparent()  # Make layer transparent to look more responsive when animating removal
	if animate:
		# Animates the dialog off screen
		var viewport_size: Vector2 = get_viewport().get_visible_rect().size
		var tween: Tween = create_tween()
		tween.tween_property(dialog, "position:y", viewport_size.y + OFFSCREEN_OFFSET, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		await tween.finished

	dialog.queue_free()

	# Remove the ModalLayer from the scene tree.
	modal_layer.queue_free()
