# =============================================================================
# events.gd
# =============================================================================
# This script defines a singleton node that holds signals used for communication
# between different parts of the game. This allows for a decoupled architecture
# where components can react to events without needing direct references to each
# other.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node

# Scene Manager
signal load_start(loading_screen: LoadingScreen)
signal scene_added(loaded_scene: Node, loading_screen: LoadingScreen)
signal load_complete(loaded_scene: Node)
signal transition_in_complete
signal scene_finished_loading(scene: Node)
signal scene_invalid(scene_path: String)
signal scene_failed_to_load(scene_path: String)
signal scene_change_requested(scene_path: String)

# Modal Manager
signal show_dialog(dialog: PackedScene, animate: bool)
signal close_dialog(dialog: Control, animate: bool)

# Main Menu
signal quit_game_requested
signal settings_changed

# Game state
signal hands_changed(new_amount: int)
signal discards_changed(new_amount: int)
signal money_changed(new_amount: int)
signal ante_changed(new_ante_amount: int, new_target_amount: int)
signal round_changed(new_round: int)
signal scored_hand_changed(scored_hand: String, score_hand_level: String)
signal chips_changed(new_amount: int)
signal mult_changed(new_amout: int)
signal phase_changed(new_phase: GameController.Phase)
signal round_score_changed(new_amount: int)
