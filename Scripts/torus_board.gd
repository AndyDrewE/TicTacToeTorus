extends MeshInstance3D

@onready var board = $board

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_board()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func draw_board():
	##Draw Vertical lines
	var radius = (mesh.outer_radius - mesh.inner_radius)/2
	board.clear()
	var orientation = board._scale_basis(radius)
	
	for i in range(3):
		var x = (mesh.inner_radius + radius)*cos(i*TAU/3)
		var y = 0
		var z = (mesh.inner_radius + radius)*sin(i*TAU/3)
		var center = Vector3(x,y,z)
		orientation = orientation.rotated(Vector3.RIGHT, TAU/4)
		board.circle(center, orientation, Color.BLACK)
