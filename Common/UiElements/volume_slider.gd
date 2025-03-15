# =============================================================================
# VolumeSlider.gd
# =============================================================================
# This script defines a custom control for adjusting audio volume. It provides
# a slider and label to allow the user to interactively set the volume level.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name VolumeSlider
extends Control

## Signal emitted when the volume value changes.
## @param value The new volume value.
signal volume_changed(value: float)

## The text to display on the volume slider's label.
@export var _display_text: String = ""

## A reference to the volume slider label.
@onready var _volume_slider_label: Label = $VolumeSliderVBoxContainer/VolumeSliderLabel

## A reference to the volume slider.
@onready var _volume_slider: HSlider = $VolumeSliderVBoxContainer/VolumeSlider


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_volume_slider_label.text = _display_text


## Gets the current volume value.
## @return The current volume value in decibels.
func get_value() -> float:
	return linear_to_db(_volume_slider.value / 100.0)


## Sets the current volume value.
## @param volume_db The volume value to set in decibels.
func set_value(volume_db: float) -> void:
	_volume_slider.value = clamp(db_to_linear(volume_db) * 100, 0, 100)


## Called when the volume slider's value changes.
## Emits the volume_changed signal with the new value.
func _on_volume_slider_value_changed(_value: float) -> void:
	volume_changed.emit(get_value())
