extends CanvasLayer

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	worldSignals.connect("player_death", Callable(self, "player_death"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		if Input.is_action_pressed("enter"):
			dead = false
			$death.visible = false
			get_tree().reload_current_scene()


#signals
func player_death():
	print("player_death")
	$death.visible = true
	dead = true
