extends Button

@export var normal: Marker2D
@export var enabled: bool = true

var _time: float = 0.0
var _value: float = 2000
var _mousepos: Vector2 = Vector2(0, 0)
var _is_dragging_card: bool = false
var _veldir: Vector2 = Vector2(0, 0)
var _oldpos: Vector2 = Vector2(0, 0)
var _veldir2: Vector2 = Vector2(0, 0)
var _oldpos2: Vector2 = Vector2(0, 0)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and enabled:
		_mousepos = event.position - (Vector2(140, 186) / 2)
		_veldir = clamp(event.velocity / 4000, Vector2(-0.3, -0.3), Vector2(0.3, 0.3))
	if event is InputEventMouseButton and enabled:
		if event.button_index == 1 and event.pressed == false:
			_is_dragging_card = 0


func _process(delta: float) -> void:
	if enabled:
		self.visible = true
		_time += 1 * delta
		if _is_dragging_card:
			self.position = lerp(self.position, _mousepos, 0.25)
			self.rotation += clamp(_veldir.x, -0.3, 0.3)
			self.rotation *= 0.8
			self.scale = lerp(self.scale, Vector2(1.05, 1.05), 0.25)
			_oldpos = _mousepos
			_veldir *= 0
		else:
			self.position = lerp(self.position, normal.position, 0.25)
			_veldir2 = (self.position - _oldpos2) * 0.01532
			_oldpos2 = self.position
			self.rotation += clamp(_veldir2.x, -0.3, 0.25)
			self.rotation *= 0.8
			_veldir2 = (self.position - _oldpos2) * 0.01532
			self.rotation += sin(_time + 1321) * (0.003625 / 2)
			self.position.x += cos(_time + 180 + 1321) * (0.875 / 2)
			self.position.y += sin(_time + 360 + 1231) * (0.875 / 2)
			var card_material: Material = material
			if is_cursor_touching() and enabled:
				if card_material:
					self.scale = lerp(self.scale, Vector2(1.05, 1.05), 0.25)
					card_material.set_shader_parameter("hovering", 1)
					card_material.set_shader_parameter(
						"mouse_screen_pos", Vector2(clampf((get_global_mouse_position() - (self.position + self.size / 2)).x * 2, -_value, _value), clampf((get_global_mouse_position() - (self.position + self.size / 2)).y * 2, -_value, _value))
					)
			else:
				if card_material:
					self.scale = lerp(self.scale, Vector2(1, 1), 0.25)
					card_material.set_shader_parameter("hovering", 0)
	else:
		self.position = normal.position
		self.rotation = 0
		self.visible = false


func _on_button_down() -> void:
	print("Button down")
	_is_dragging_card = true


# Returns true if the cursor is touching the sprite.
func is_cursor_touching() -> bool:
	# Get the mouse position in global coordinates.
	var mouse_pos: Vector2 = get_global_mouse_position()
	var start: Vector2 = self.global_position
	var end: Vector2 = self.global_position + self.size
	var below_top_left: bool = mouse_pos.x >= start.x and mouse_pos.y >= start.y
	var above_bottom_right: bool = mouse_pos.x <= end.x and mouse_pos.y <= end.y
	return below_top_left and above_bottom_right
