extends Node2D

const SPEED = 60
var direction = 1 # 1 is Right, -1 is Left

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
# Make sure your node is named exactly "AnimatedSprite2D"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	# 1. Check for walls to change direction
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	
	# 2. Move the enemy
	position.x += direction * SPEED * delta
	
	# 3. Handle Sprite Flipping and Animation
	if direction < 0:
		animated_sprite.flip_h = false # Face Right
	else:
		animated_sprite.flip_h = true  # Face Left
		
	# Play the walk animation if it exists
	animated_sprite.play("walk")
