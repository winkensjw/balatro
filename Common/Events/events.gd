extends Node

# Scene Manager
signal load_start(loading_screen: LoadingScreen)
signal scene_added(loaded_scene: Node, loading_screen: LoadingScreen)
signal load_complete(loaded_scene: Node)
signal transition_in_complete
signal scene_finished_loading(scene: Node)
signal scene_invalid(scene_path: String)
signal scene_failed_to_load(scene_path: String)

# Main Menu
signal main_menu_closed
signal quit_game_requested

# Add events here
