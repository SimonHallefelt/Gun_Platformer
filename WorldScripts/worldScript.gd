extends Node

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		start_pause()

func start_pause():
	if active:
		var pause = load(worldScenes.pause)
		pause.instantiate()
		owner.add_child(pause)
		stop_game()

func stop_game():
	get_tree().paused = true
	active = false

func start_game():
	get_tree().paused = false
	active = true
