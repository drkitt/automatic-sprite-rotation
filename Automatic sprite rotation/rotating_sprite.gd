# Displays an image based on the sprite's orientation relative to the camera.
# The intended use is to get the kind of sprite rotation you'd see in a 
# top-down 2D game, except done automatically based on 3D camera movement.

extends AnimatedSprite3D

const IDLE_DIRECTION_ANIMATIONS = [
	"idle dir 0",
	"idle dir 1",
	"idle dir 2",
	"idle dir 3",
	"idle dir 4",
	"idle dir 5",
	"idle dir 6",
	"idle dir 7",
	"idle dir 8",
	"idle dir 9",
	"idle dir 10",
	"idle dir 11",
	"idle dir 12",
	"idle dir 13",
	"idle dir 14",
	"idle dir 15",
]

# Private variables
# The camera that this sprite is rotating based on
var camera: Camera

# Called when the node first enters the scene tree
func _ready() -> void:
	# Preconditions:	
	# There's a viewport (pretty sure this is guaranteed but whatever)
	assert(get_viewport())
	# There's a camera (this one isn't guaranteed)
	assert(get_viewport().get_camera())
	
	# Get the camera
	camera = get_viewport().get_camera()
	

# Called every frame
# Parameters: 
#	- delta: The elapsed time since the previous frame
func _process(_delta: float) -> void:
	# Calculate the orientation of the sprite (around the global y axis, 
	# relative to the camera, in radians)
	var relative_angle: float = global_transform.basis.get_euler().y + \
			PI/2 - _get_camera_angle()
	relative_angle = wrapf(relative_angle, 0, TAU)
	
	# Display the texture that best corresponds to the orientation
#	var frame = _round_angle(relative_angle, frames.get_frame_count(animation))
	var frame_index = _round_angle(relative_angle, len(IDLE_DIRECTION_ANIMATIONS))
	animation = IDLE_DIRECTION_ANIMATIONS[frame_index]
	

# Gets the orientation of the camera
# Returns: The camera's orientation, expressed as an angle around the global y 
# axis in radians. Note that global angles are in [-pi, pi] instead of [0, 2pi] 
# for some reason.
func _get_camera_angle() -> float:
	var view_camera = get_viewport().get_camera()
	# The angle is increased by PI/2 because a camera with rotation 0 will look 
	# directly upwards, which is better described as having rotation PI/2
	var angle: float = view_camera.global_transform.basis.get_euler().y + PI/2
	# Wrap the angle to be in line with the usual global angles
	angle = wrapf(angle, -PI, PI)
	
	# Postconditions:
	# The angle is in [-pi, pi], since that's apparently how global angles do
	assert(angle >= -PI)
	assert(angle <= PI)
	
	return angle


# Rounds an angle to the closest "edge" of a divided circle. To understand what 
# I mean by edges, imagine cutting a pizza into an arbitrary number of 
# equal-sized slices (with the first slice made at angle 0); this method will 
# round any angle to the nearest edge of a slice.
# For example, if there are four edges/slices, then this method will round the 
# given angle to the closest one of 0, pi/2, pi, and 3pi/2
#
# Parameters:
#	- angle: The angle to round
#	- slices: How many slices to split the circle into
#
# Returns: angle, rounded to the nearest segment
func _round_angle(angle: float, slices: int) -> int:
	# Preconditions:
	# The number of slices is positive (you can't just cut a pizza into zero 
	# slices) 
	assert(slices > 0)
	
	var slice: int = int((angle * slices)/TAU + 0.5)
	# The non-simplified equation is:
	# theta' = floor((theta + (1/2 * 2pi/s) * s/2pi)
	# where theta = angle and s = slices. 
	#
	# It basically works by increasing the angle by half the size of a single 
	# slice (by adding (1/2 * 2pi/s)), which ensures that the floor operation 
	# rounds it down to the edge that the original angle was closest to 
	# (similarly to how you can round a number to the nearest integer by adding 
	# 0.5 to it and then flooring it). The multiplication by s/2pi converts the 
	# number from an angle to an edge number, and we're (mostly) done! Just 
	# gotta wrap it to ensure that the return value is in the range [0, s]

	# The return value is guaranteed to be an int by the joy of static typing, 
	# and it's guaranteed to be in the correct range by the wrapi method, so no
	# postconditions here!
	return wrapi(slice, 0, slices)
