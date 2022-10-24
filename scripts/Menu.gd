extends Control

func _physics_process(delta):
	$BGParallax.scroll_base_offset += Vector2(-1, 0) * 32 * delta
	$BGParallax2.scroll_base_offset += Vector2(-1, 0) * 64 * delta

func _on_Button_pressed():
	return get_tree().change_scene("res://scenes/Level.tscn")
