extends Area2D

var dead = false

func _process(delta):
	if dead == false:
		$AnimatedSprite.play("default")
		



func _on_Enemy_area_entered(area):
	if area.is_in_group("sword"):
		queue_free()
