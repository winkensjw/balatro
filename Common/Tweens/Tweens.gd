# =============================================================================
# Tweens.gd
# =============================================================================
# This script provides a utility function for creating a Tween object.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node


## Creates and returns a new Tween object.
## @return A new Tween object created from the scene tree.
func create() -> Tween:
	return get_tree().create_tween()
