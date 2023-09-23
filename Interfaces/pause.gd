extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		print("pause = ", get_tree().paused)


func _on_continue_pressed():
	get_tree().paused = false
	visible = false
	print("pause = ", get_tree().paused)


func _on_main_menu_pressed():
	pass # Replace with function body.
