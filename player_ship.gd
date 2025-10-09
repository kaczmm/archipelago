extends Node3D

# Camera controls
var mouse_sensitivity = 0.002
var gamepad_sensitivity = 2.0
var mouse_movement = Vector2()

# Bobbing
var bob_speed = 1.0
var bob_height = 0.2
var base_height = 0.0
var time = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Ship.gravity_scale = 0.0
	$Ship.lock_rotation = true
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement += event.relative
	if event.is_action_pressed("action_pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta):
	time += delta
	
	# Bob up and down
	var target_y = bob_height * sin(time * bob_speed)
	position.y = target_y
	# Bobbing tilt
	rotation.z = sin(time * bob_speed * 0.8) * 0.01
	rotation.x = cos(time * bob_speed * 0.6) * 0.01
	
	if mouse_movement != Vector2():
		$Ship/CameraH.rotation_degrees.y -= mouse_movement.x
		$Ship/CameraH/CameraV.rotation_degrees.x -= mouse_movement.y
		if $Ship/CameraH/CameraV.rotation_degrees.x <= -55:
			$Ship/CameraH/CameraV.rotation_degrees.x = -55
		if $Ship/CameraH/CameraV.rotation_degrees.x >= 22:
			$Ship/CameraH/CameraV.rotation_degrees.x = 22
		mouse_movement = Vector2()
