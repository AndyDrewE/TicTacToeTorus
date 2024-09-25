extends TextureRect

@onready var board_grid = $board_grid
@onready var boxes = board_grid.get_children()

var CROSS_TEX = preload("res://Assets/cross.png")
var CIRCLE_TEX = preload("res://Assets/circle.png")

var cross_style : StyleBoxTexture
var circle_style : StyleBoxTexture

##GAME CONTROLLER STUFF
var turn_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	board_grid.size = size
	for box in boxes:
		box.gui_input.connect(box_gui_input.bind(box))
	
	cross_style = StyleBoxTexture.new()
	circle_style = StyleBoxTexture.new()
	
	cross_style.texture = CROSS_TEX
	circle_style.texture = CIRCLE_TEX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func box_gui_input(event : InputEvent, box : Panel):
	var box_style = box.get('theme_override_styles/panel')
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if box_style != null:
				print("Pick somewhere else")
			else:
				## X's turn
				if turn_counter % 2 == 0:
					box.set('theme_override_styles/panel',cross_style)
					turn_counter += 1
				elif turn_counter %2 == 1:
					box.set('theme_override_styles/panel', circle_style)
					turn_counter += 1
