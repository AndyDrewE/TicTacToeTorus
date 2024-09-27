extends Node3D

@onready var camera = $Camera3D

var current_fov = 90
var min_fov = 30
var max_fov = 130
var fov_step = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		current_fov = current_fov - fov_step
	elif Input.is_action_pressed("ui_down"):
		current_fov = current_fov + fov_step
	current_fov = clamp(current_fov, min_fov, max_fov)
	
	if camera.fov != current_fov:
		camera.set_fov(current_fov)
