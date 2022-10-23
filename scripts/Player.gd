extends KinematicBody2D

var isAttacking = false
var isJumping = false

onready var animationp = $AnimationPlayer
onready var animations = $AnimatedSprite

# Jumps
const speed = 50
const maxSpeed = 75

const jumpHeight = 300
const time_jump = 0.7
var jump_force
const up = Vector2(0, -1)
var gravity = 15

func _ready():
	animations.play("Idle")
	
	

var motion = Vector2.ZERO

func _physics_process(delta):
		
	gravity = (2 * jumpHeight) / pow(time_jump, 2)
	jump_force = gravity * time_jump
	motion.y += gravity * delta
	var friction = false
	
	if Input.is_action_just_pressed("Attack1")  && isAttacking == false:
		animations.animation = "Attack1"			
		animationp.play("Attack1")				
		isAttacking = true
	
	if Input.is_action_just_pressed("Attack2") && isAttacking == false:
		animations.animation = "Attack2"			
		animationp.play("Attack2")		
		isAttacking = true
	
	if Input.is_action_pressed("ui_right") && isAttacking == false:
		motion.x = min(motion.x + speed, maxSpeed)
		if isJumping == false && isAttacking == false:
			animations.animation = "Run"
		animations.flip_h = false
	elif Input.is_action_pressed("ui_left") && isAttacking == false:		
		motion.x = max(motion.x - speed, -maxSpeed)
		if isJumping == false && isAttacking == false: 
			animations.animation = "Run"
		animations.flip_h = true
	else:		
		friction = true
		if isJumping == false && isAttacking == false:			
			animations.animation = "Idle"
	if is_on_floor():
		isJumping = false
		if Input.is_action_pressed("ui_accept"):			
			motion.y = -jumpHeight
			isJumping = true
		if friction == true:
			motion.x = lerp(motion.x, 0 , 0.5)
	else:
		isJumping = true
		if friction == true:
			motion.x = lerp(motion.x, 0 , 0.1)
		if motion.y < 0: 
			if isAttacking == false:			
				animations.animation = "Jump"
		else:
			if isAttacking == false:
				animations.animation = "Fall"		
	motion = move_and_slide(motion, up)



func _on_AnimatedSprite_animation_finished():
	print("anim finished")
	if animations.animation == "Attack1":
		isAttacking = false
		$AttackArea/CollisionPolygon2D.disabled = true		
	if animations.animation == "Attack2":
		isAttacking = false
		$AttackArea/CollisionPolygon2D.disabled = true		
	if animations.animation == "Fall":
		isAttacking = false
		$AttackArea/CollisionPolygon2D.disabled = true		
"""
func _physics_process(delta):
	motion_ctrl()
	animation_ctrl()
	
	if is_on_floor():
		motion.y = 0
		isJumping = false
	else:
		motion.y += gravity * delta
	
	if Input.is_action_pressed("ui_accept"):
		isJumping = true
		motion.y = 0
		if is_on_floor():
			motion.y += jump_height
			animations.animation = "Jump"
	motion = move_and_slide(motion,Vector2(0, -1))		

	
func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))	
	return axis

func motion_ctrl():
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = get_axis()
		motion.x = motion.x  * SPEED		
		
	
func animation_ctrl():
	if get_axis().x == 1 && isAttacking == false && isJumping == false:
		animations.animation = "Run"
		animations.flip_h = false
	elif get_axis().x == -1 && isAttacking == false && isJumping == false:
		animations.animation = "Run"
		animations.flip_h = true
	else:
		if isAttacking == false && isJumping == false:			
			animations.animation = "Idle"
		
	
	if Input.is_action_just_pressed("Attack1"):
		animations.animation = "Attack1"			
		animationp.play("Attack1")
		#$AttackArea/CollisionPolygon2D.disabled = false
		isAttacking = true


"""
