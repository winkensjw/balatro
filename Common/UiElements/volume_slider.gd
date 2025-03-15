# Volume Slider
class_name VolumeSlider
extends Control

signal volume_changed(value: float)

@export var m_property_name: String = ""
@export var m_display_text: String = ""

@onready var m_volume_slider_label: Label = $VolumeSliderVBoxContainer/VolumeSliderLabel
@onready var m_volume_slider: HSlider = $VolumeSliderVBoxContainer/VolumeSlider


func _ready() -> void:
	m_volume_slider_label.text = m_display_text


func get_value() -> float:
	return linear_to_db(m_volume_slider.value / 100.0)


func set_value(volume_db: float) -> void:
	m_volume_slider.value = clamp(db_to_linear(volume_db) * 100, 0, 100)


func _on_volume_slider_value_changed(_value: float) -> void:
	volume_changed.emit(get_value())
