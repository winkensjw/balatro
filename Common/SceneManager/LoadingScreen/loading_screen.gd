class_name LoadingScreen extends CanvasLayer

const LOADING_SCREEN_SCENE:PackedScene = preload(Constants.LOADING_SCREENE_SCENE_PATH)

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var timer: Timer = $Timer

var starting_animation_name:String

static func create() -> LoadingScreen:
	return LOADING_SCREEN_SCENE.instantiate();

func _ready() -> void:
	# only show progress bar if loading takes too long
	progress_bar.visible = false
	pass
	
func start_transition(animation_name:String) -> void: 
	if !anim_player.has_animation(animation_name):
		Log.warn("'%s' animation does not exist" % animation_name)
		animation_name = "fade_to_black"
	starting_animation_name = animation_name
	anim_player.play(animation_name)
	
	# if timer reaches the end before we finish loading, this will show the progress bar
	timer.start()
	
func finish_transition() -> void:
	if timer:
		timer.stop()
		
	var ending_animation_name:String = starting_animation_name.replace("to","from")
	
	if !anim_player.has_animation(ending_animation_name):
		Log.warn("'%s' animation does not exist" % ending_animation_name)
		ending_animation_name = "fade_from_black"
		
	anim_player.play(ending_animation_name)
	await anim_player.animation_finished
	queue_free()

func report_midpoint() -> void:
	Events.transition_in_complete.emit()

func _on_timer_timeout() -> void:
	progress_bar.visible = true

func update_bar(val:float) -> void:
	progress_bar.value = val
