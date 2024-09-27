extends MeshInstance3D


var rotating = false

var prev_mouse_position
var next_mouse_position

var rotation_speed = 0.5

func _process(delta):
	if (Input.is_action_just_pressed("ui_rotate")):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("ui_rotate")):
		rotating = false
		
	if (rotating):
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_y((next_mouse_position.x - prev_mouse_position.x) * rotation_speed * delta)
		rotate_z(-(next_mouse_position.y - prev_mouse_position.y) * rotation_speed * delta)
		prev_mouse_position = next_mouse_position
		
