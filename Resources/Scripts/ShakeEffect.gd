extends Node  # Replace 'Sprite' with the actual type of node you're using

var shake_duration = 1.0  # Adjust the duration of the shake (in seconds)
var shake_amount = 2.0  # Adjust the intensity of the shake

@export var sprite: Sprite2D

# Initialize variables
var is_shaking = true
var original_position = Vector2(0, 0)
var shake_timer = 0.2

func _ready():
	# Store the original position of the sprite
	original_position = sprite.position

func start_shake():
	if !is_shaking:
		is_shaking = true
		shake_timer = shake_duration
		original_position = sprite.position

func _process(delta):
	if is_shaking:
		# Reduce the shake_timer by the time passed in the frame
		shake_timer -= delta

		# Check if the shake duration is over
		if shake_timer <= 0:
			is_shaking = false
			sprite.position = original_position  # Reset the sprite's position
		else:
			# Apply random offset to simulate shaking
			var offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
			sprite.position = original_position + offset
