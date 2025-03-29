# =============================================================================
# loading_screen.gd
# =============================================================================
# This script manages the loading screen, displaying a progress bar and
# playing animations during scene transitions.
#
# @author winkensjw
# @version 1.0
# =============================================================================

class_name LoadingScreen extends CanvasLayer

## The PackedScene for this LoadingScreen.
const LOADING_SCREEN_SCENE: PackedScene = preload(Constants.LOADING_SCREENE_SCENE_PATH)

## The name of the starting animation.
var _starting_animation_name: String

## Logger instance for this class.
## Used to output debug messages.
var _log: Log = Log.new("LoadingScreen")

## A reference to the ProgressBar node.
@onready var _progress_bar: ProgressBar = %ProgressBar

## A reference to the AnimationPlayer node.
@onready var _anim_player: AnimationPlayer = %AnimationPlayer

## A reference to the Timer node.
@onready var _timer: Timer = $Timer


## Creates a new instance of the LoadingScreen scene.
## @return A new LoadingScreen instance.
static func create() -> LoadingScreen:
	return LOADING_SCREEN_SCENE.instantiate()


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Only show progress bar if loading takes too long.
	_progress_bar.visible = false


## Starts the transition animation.
## @param animation_name The name of the animation to play.
func start_transition(animation_name: String) -> void:
	if not _anim_player.has_animation(animation_name):
		_log.warn("'%s' animation does not exist" % animation_name)
		animation_name = "fade_to_black"
	_starting_animation_name = animation_name
	_anim_player.play(animation_name)

	## If _timer reaches the end before we finish loading, this will show the progress bar.
	_timer.start()


## Finishes the transition animation and frees the loading screen.
func finish_transition() -> void:
	if _timer:
		_timer.stop()

	var ending_animation_name: String = _starting_animation_name.replace("to", "from")

	if not _anim_player.has_animation(ending_animation_name):
		_log.warn("'%s' animation does not exist" % ending_animation_name)
		ending_animation_name = "fade_from_black"

	_anim_player.play(ending_animation_name)
	await _anim_player.animation_finished
	queue_free()


## Emits the transition_in_complete signal to indicate the midpoint of the transition.
func report_midpoint() -> void:
	Events.transition_in_complete.emit()


## Called when the _timer times out.
## Makes the progress bar visible.
func _on_timer_timeout() -> void:
	_progress_bar.visible = true


## Updates the progress bar value.
## @param val The new progress bar value.
func update_bar(val: float) -> void:
	_progress_bar.value = val
