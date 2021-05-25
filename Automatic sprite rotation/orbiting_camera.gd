# Allows a camera to rotate around its parent

tool
extends Spatial

# Exported variables
# How quickly the camera should rotate, in radians per second
export(float) var rotation_speed = 2 * PI
# Whether to automatically rotate the camera (for demonstration purposes)
export(bool) var auto_rotate = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Determine rotation direction using a number in [-1, +1] representing the 
	# player's horizontal input
	var rotation_direction: float
	if auto_rotate:
		rotation_direction = 1
	elif not Engine.editor_hint:
		rotation_direction = Input.get_action_strength("camera_right") \
			- Input.get_action_strength("camera_left")
				
	# Orbit around the player according to input
	rotation.y += rotation_direction * rotation_speed * delta
	rotation.y = wrapf(rotation.y, 0, TAU)
