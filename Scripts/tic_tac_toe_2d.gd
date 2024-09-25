extends TextureRect

@onready var board_grid = $board_grid
@onready var panels = board_grid.get_children()

var CROSS_TEX = preload("res://Assets/cross.png")
var CIRCLE_TEX = preload("res://Assets/circle.png")

var cross_style : StyleBoxTexture
var circle_style : StyleBoxTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	board_grid.size = size
	for panel in panels:
		print(panel)
	
	cross_style = StyleBoxTexture.new()
	circle_style = StyleBoxTexture.new()
	
	cross_style.texture = CROSS_TEX
	circle_style.texture = CIRCLE_TEX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func panel_gui_input(event : InputEvent, panel : Panel):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			print(panel)
