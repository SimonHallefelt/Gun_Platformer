extends CanvasLayer

var start_level = load(worldScenes.level_1)


#buttens
func _on_start_pressed():
	get_tree().change_scene_to_packed(start_level)

func _on_exit_pressed():
	get_tree().quit()
