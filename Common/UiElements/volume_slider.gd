# Volume Slider
class_name VolumeSlider
extends Control

@export var m_property_name: String = ""
@export var m_display_text: String = ""

@onready var volume_slider_label: Label = $VolumeSliderVBoxContainer/VolumeSliderLabel


func _ready() -> void:
	volume_slider_label.text = m_display_text
