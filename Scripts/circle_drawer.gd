extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var circle = draw_circle(2, 10)
	add_child(circle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func draw_circle(radius, segments):
	var vertices = PackedVector3Array()
		
	for i in range(segments):
		var phi = (i/float(segments))*TAU
		var x = radius * cos(phi)
		var y = radius * sin(phi)
		vertices.push_back(Vector3(x,y,0))
		
	
	var circle_mesh = ArrayMesh.new()
	var vertex_array = []
	vertex_array.resize(Mesh.ARRAY_MAX)
	vertex_array[Mesh.ARRAY_VERTEX] = vertices
	
	circle_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, vertex_array)
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = circle_mesh
	
	return mesh_instance
