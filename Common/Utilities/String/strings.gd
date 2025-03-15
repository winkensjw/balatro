# =============================================================================
# strings.gd
# =============================================================================
# This script provides utility functions for string manipulation.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node


## Joins an array of strings using a specified delimiter.
## @param delimiter The string to use as the delimiter.
## @param parts The array of strings to join.
## @return The joined string.
func join(delimiter: String, parts: PackedStringArray) -> String:
	return delimiter.join(parts)
