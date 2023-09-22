extends CanvasLayer

#death
var dead = false

#hp
@onready var hpBar = $hp_bar
var color_green = Color(0, 1, 0.1176, 1) #00ff1e
var color_yellow = Color(0.9, 0.9, 0, 1)
var color_red = Color(1, 0, 0, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	worldSignals.connect("player_death", Callable(self, "_on_player_death"))
	worldSignals.connect("player_health", Callable(self, "_on_player_health"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		if Input.is_action_just_pressed("enter"):
			dead = false
			$death.visible = false
			get_tree().reload_current_scene()


#signals
func _on_player_health(hp, max_hp):
	print("player_health ", hp, " ", max_hp)
	hpBar.max_value = max_hp
	hpBar.value = hp
	if hp > max_hp * 0.7:
		hpBar.tint_progress = color_green
	elif hp > max_hp * 0.3:
		hpBar.tint_progress = color_yellow
	else:
		hpBar.tint_progress = color_red

func _on_player_death():
	print("player_death")
	$death.visible = true
	dead = true
