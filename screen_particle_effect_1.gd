extends GPUParticles2D

var player_pos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	worldSignals.connect("player_position", Callable(self, "_on_player_position"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screen_size = get_viewport_transform()
	#position.x = -screen_size.get_origin().x - 100
	#position.y = player_pos.y

func _on_player_position(pos):
	player_pos = pos
