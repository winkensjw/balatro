# =============================================================================
# save_manager_settings.gd
# =============================================================================
# This script defines a Resource class that holds settings for the SaveManager.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name SaveManagerSettings
extends Resource

## Whether to automatically save the game data when the game window is closed.
@export var save_on_close: bool = false
