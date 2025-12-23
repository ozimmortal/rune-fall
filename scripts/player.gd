extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2  # How many times you can jump (2 = Double Jump)

var jump_count = 0   # Track current jumps

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Reset jumps when touching the floor
	if is_on_floor():
		jump_count = 0

	# Handle jump
	# We check if 'jump' is pressed AND we have jumps remaining
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
		# Optional: Force the jump animation to restart so it looks snappy
		animated_sprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# --- ANIMATION HANDLING ---
	update_animation(direction)

func update_animation(direction):
	# 1. Flip the sprite based on direction
	if direction > 0:
		animated_sprite.flip_h = false # Face right
	elif direction < 0:
		animated_sprite.flip_h = true  # Face left
	
	# 2. Check if jumping (in the air)
	if not is_on_floor():
		# Only switch to jump animation if we aren't already playing it
		# (Unless we just double jumped, which is handled in the input section)
		if animated_sprite.animation != "jump":
			animated_sprite.play("jump")
	
	# 3. Check if on floor
	else:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
