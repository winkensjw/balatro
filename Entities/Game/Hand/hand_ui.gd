class_name HandArea
extends Control

# FIXME remove debug hand
var _card_resource: CardResource = preload(Constants.CARD_SCENE_DICT[Card.Suit.SPADES][Card.Rank.A])

var _cards_to_display: int = 12
var _card_width: int = 142
var _margin_px: int = 30


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_add_cards.call_deferred()


func _add_cards() -> void:
	var card_positions: Array[Vector2] = compute_card_positions()
	for card_position: Vector2 in card_positions:
		var card: Card = Card.new(_card_resource)
		var card_ui: CardUi = card.get_ui()
		add_child(card_ui)
		card_ui.global_position = card_position
		card_ui.set_snap_back_position(card_position)


func compute_card_positions() -> Array[Vector2]:
	var start: Vector2 = global_position
	start.x += _margin_px
	var end: Vector2 = global_position
	end.x += get_child(0).size.x - _margin_px - _card_width
	return compute_equidistant_positions(start, end, _cards_to_display, _card_width + 10)


func compute_equidistant_positions(start: Vector2, end: Vector2, n: int, max_spacing: float) -> Array[Vector2]:
	var positions: Array[Vector2] = []

	if n <= 0:
		return positions  # Return an empty array if n is zero or negative

	var total_distance: float = start.distance_to(end)

	if n == 1:
		positions.append((start + end) / 2.0)
		return positions

	# Calculate the actual spacing based on the total distance and number of positions
	var spacing: float = min(max_spacing, total_distance / float(n - 1))

	# Calculate the total length needed for all positions
	var required_length: float = spacing * float(n - 1)

	# Calculate the starting offset to center the positions
	var offset: float = (total_distance - required_length) / 2.0

	# Normalize the direction vector from start to end
	var direction: Vector2 = (end - start).normalized()

	# Calculate the positions along the line
	for i in range(n):
		var current_distance: float = offset + float(i) * spacing
		var new_position: Vector2 = start + direction * current_distance
		new_position += Vector2(142, 190) / 2  # card offset
		positions.append(new_position)

	return positions


func _add_marker(pos: Vector2) -> Marker2D:
	var marker: Marker2D = Marker2D.new()
	add_child(marker)
	marker.global_position = pos
	var label: Label = Label.new()
	label.text = "X"
	marker.add_child(label)
	return marker
