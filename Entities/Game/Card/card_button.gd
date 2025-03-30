extends Button

@export var snap_back_position: Marker2D
@export var enabled: bool = true

var _time: float = 0.0
var _mousepos: Vector2 = Vector2(0, 0)
var _is_dragging_card: bool = false
var _veldir: Vector2 = Vector2(0, 0)
var _oldpos: Vector2 = Vector2(0, 0)
var _veldir2: Vector2 = Vector2(0, 0)
var _oldpos2: Vector2 = Vector2(0, 0)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and enabled:
		_mousepos = event.position + _get_card_offset()
		_veldir = clamp(event.velocity / 4000, Vector2(-0.3, -0.3), Vector2(0.3, 0.3))
	if event is InputEventMouseButton and enabled:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			_is_dragging_card = false


func _process(delta: float) -> void:
	if enabled:
		visible = true
		_time += 1 * delta
		if _is_dragging_card:
			_move_card_to_mouse_pos()
		else:
			_move_card_to_snap_back_position()
	else:
		hide_card()


func _on_button_down() -> void:
	_is_dragging_card = true


func _get_snap_back_position() -> Vector2:
	if snap_back_position != null:
		return snap_back_position.position + _get_card_offset()
	return Vector2.ZERO + _get_card_offset()


func set_snap_back_position(pos: Marker2D) -> void:
	snap_back_position = pos


func _get_card_offset() -> Vector2:
	return -(Vector2(142, 190) / 2)


func _get_zoom_factor() -> Vector2:
	return Vector2(1.05, 1.05)


func hide_card() -> void:
	position = _get_snap_back_position()
	rotation = 0
	visible = false


func _move_card_to_mouse_pos() -> void:
	position = lerp(position, _mousepos, 0.25)
	rotation += clamp(_veldir.x, -0.3, 0.3)
	rotation *= 0.8
	scale = lerp(scale, _get_zoom_factor(), 0.25)
	_oldpos = _mousepos
	_veldir *= 0


func _move_card_to_snap_back_position() -> void:
	position = lerp(position, _get_snap_back_position(), 0.25)
	_veldir2 = (position - _oldpos2) * 0.01532
	_oldpos2 = position
	rotation += clamp(_veldir2.x, -0.3, 0.25)
	rotation *= 0.8
	_veldir2 = (position - _oldpos2) * 0.01532
	rotation += sin(_time + 1321) * (0.003625 / 2)
	position.x += cos(_time + 180 + 1321) * (0.875 / 2)
	position.y += sin(_time + 360 + 1231) * (0.875 / 2)


func is_cursor_touching() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var start: Vector2 = global_position
	var end: Vector2 = global_position + size
	var below_top_left: bool = mouse_pos.x >= start.x and mouse_pos.y >= start.y
	var above_bottom_right: bool = mouse_pos.x <= end.x and mouse_pos.y <= end.y
	return below_top_left and above_bottom_right
