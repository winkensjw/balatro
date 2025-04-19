## ============================================================================
## CardUi.gd
## ============================================================================
## Represents a card in the game, allowing it to be dragged by the player.
## This class manages the visual appearance of the card (position, rotation,
## scale) and its behavior during drag and drop actions.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name CardUi
extends Button

## The Marker2D that represents the card's resting position.
@export var snap_back_position: Marker2D

## Determines whether the card is active and can be interacted with.
@export var enabled: bool = true

var _log: Log = Log.new("CardUi")

var _card: Card

var _time: float = randf_range(0, 1000)
var _mousepos: Vector2 = Vector2(0, 0)
var _is_dragging_card: bool = false
var _veldir: Vector2 = Vector2(0, 0)
var _oldpos: Vector2 = Vector2(0, 0)
var _veldir2: Vector2 = Vector2(0, 0)
var _oldpos2: Vector2 = Vector2(0, 0)

##Reference to the sprite
@onready var _sprite: Sprite2D = $Sprite


func _ready() -> void:
	_sprite.texture = _card.get_texture()


func set_card(card: Card) -> void:
	_card = card


## Called every frame.  Updates the card's appearance and behavior.
## @param delta: float The time elapsed since the last frame.
func _process(delta: float) -> void:
	if enabled:
		show_card()
		_time += 1 * delta
		if _is_dragging_card:
			_move_card_to_mouse_pos()
		else:
			_move_card_to_snap_back_position()
			_animate_floating()
	else:
		hide_card()


## Called when the card is pressed.  Sets the card to be dragged.
func _on_button_down() -> void:
	_is_dragging_card = true


## Handles input events, such as mouse motion and mouse button presses.
## @param event: InputEvent The input event that occurred.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and enabled:
		_mousepos = event.position + _get_card_offset()
		_veldir = clamp(event.velocity / 4000, Vector2(-0.3, -0.3), Vector2(0.3, 0.3))
	if event is InputEventMouseButton and enabled:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			_is_dragging_card = false


## Returns the position the card should snap back to when released.
## @return Vector2 The snap back position.
func _get_snap_back_position() -> Vector2:
	if snap_back_position != null:
		return snap_back_position.global_position + _get_card_offset()
	return Vector2.ZERO + _get_card_offset()


## Sets the Marker2D that the card should snap back to.
## @param pos: Marker2D The new snap back position.
func set_snap_back_position(pos: Vector2) -> void:
	if snap_back_position == null:
		snap_back_position = Marker2D.new()
	snap_back_position.global_position = pos


## Returns the card offset.
## @return Vector2 The card offset.
func _get_card_offset() -> Vector2:
	return -(Vector2(142, 190) / 2)


## Returns the zoom factor.
## @return Vector2 The zoom factor.
func _get_zoom_factor() -> Vector2:
	return Vector2(1.05, 1.05)


## Hides the card by moving it to the snap back position and making it invisible.
func hide_card() -> void:
	global_position = _get_snap_back_position()
	rotation = 0
	visible = false


func show_card() -> void:
	visible = true


## Moves card to the given parent node at the given card position (global).
## If instant is set to true the card is teleported there instantly.
func move_card(parent: Node, card_position: Vector2, instant: bool = false) -> void:
	if get_parent() == null:
		parent.add_child(self)
	elif get_parent() != parent:
		reparent(parent, true)

	_log.debug("Moving card to position: %s" % card_position)
	if instant:
		global_position = card_position
	set_snap_back_position(card_position)


## Moves the card towards the mouse position.
func _move_card_to_mouse_pos() -> void:
	global_position = lerp(global_position, _mousepos, 0.25)
	rotation += clamp(_veldir.x, -0.3, 0.3)
	rotation *= 0.8
	scale = lerp(scale, _get_zoom_factor(), 0.25)
	_oldpos = _mousepos
	_veldir *= 0


## Moves the card towards the snap back position.
func _move_card_to_snap_back_position() -> void:
	global_position = lerp(global_position, _get_snap_back_position(), 0.25)
	_veldir2 = (position - _oldpos2) * 0.01532
	_oldpos2 = position
	rotation += clamp(_veldir2.x, -0.3, 0.25)
	rotation *= 0.8
	_veldir2 = (position - _oldpos2) * 0.01532


func _animate_floating() -> void:
	scale = lerp(scale, Vector2.ONE, 0.25)
	rotation += sin(_time + 1321) * (0.003625 / 2)
	global_position.x += cos(_time + 180 + 1321) * (0.875 / 2)
	global_position.y += sin(_time + 360 + 1231) * (0.875 / 2)
