extends Area2D

var dead = false

func _ready():
	$AnimatedSprite.play("Init")

func _on_Enemy_area_entered(area):
	if area.is_in_group("sword"):
		dead = true
		$AnimatedSprite.animation = "Death"


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Init":
		$AnimatedSprite.animation = "default"
	if $AnimatedSprite.animation == "Death" && dead:
		queue_free()
