class_name HandUi
extends Control

var _margin_px: int = 30

@onready var hand_label: Label = $HandVBoxContainer/HandLabel


func _ready() -> void:
	Events.hand_changed.connect(_on_hand_changed)
	_update_hand_label(null)


func _on_hand_changed(hand: Hand) -> void:
	_update_hand_label(hand)
	_add_cards(hand)


func _update_hand_label(hand: Hand) -> void:
	if hand == null:
		hand_label.text = ""
	else:
		hand_label.text = Strings.join("/", [hand.size(), hand.get_max_hand_size()])


func _add_cards(hand: Hand) -> void:
	var card_positions: Array[Vector2] = compute_card_positions(hand.size())
	for i in range(hand.size()):
		var card_position: Vector2 = card_positions[i]
		var card_ui: CardUi = hand._cards[i].get_ui()
		card_ui.move_card(self, card_position)


func _get_card_offset() -> Vector2:
	return Vector2(142, 190) / 2


func compute_card_positions(cards_to_display: int) -> Array[Vector2]:
	var start: Vector2 = global_position
	start.x += _margin_px
	var end: Vector2 = global_position
	end.x += get_child(0).size.x - _margin_px - Constants.CARD_WIDTH
	return compute_equidistant_positions(start, end, cards_to_display, Constants.CARD_WIDTH + 10)


func compute_equidistant_positions(start: Vector2, end: Vector2, n: int, max_spacing: float) -> Array[Vector2]:
	var positions: Array[Vector2] = []

	if n <= 0:
		return positions  # Return an empty array if n is zero or negative

	var total_distance: float = start.distance_to(end)

	if n == 1:
		positions.append((start + end) / 2.0 + _get_card_offset())
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
		new_position += _get_card_offset()
		positions.append(new_position)

	return positions
