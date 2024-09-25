extends TextureRect

@onready var board_grid = $board_grid
@onready var boxes = board_grid.get_children()

var CROSS_TEX = preload("res://Assets/cross.png")
var CIRCLE_TEX = preload("res://Assets/circle.png")

var cross_style : StyleBoxTexture
var circle_style : StyleBoxTexture

##GAME CONTROLLER STUFF
var turn_counter = 0
var playing = true
var cross_boxes = []
var circle_boxes = []

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

func update_turn(box : Panel):
	## X's turn
	if turn_counter % 2 == 0:
		box.set('theme_override_styles/panel',cross_style)
		cross_boxes.append(box.index)
		check_victory(cross_boxes)
		turn_counter += 1
	## O's turn
	elif turn_counter %2 == 1:
		box.set('theme_override_styles/panel', circle_style)
		circle_boxes.append(box.index)
		check_victory(circle_boxes)
		turn_counter += 1

func box_gui_input(event : InputEvent, box : Panel):
	var box_style = box.get('theme_override_styles/panel')
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and playing:
				if box_style != null:
					print("Pick somewhere else")
				else:
					update_turn(box)

func check_victory(box_array):
	var win_lines =[
		[Vector2i(-1,-1),Vector2i(0,-1), Vector2i(1,-1)],#ROWS
		[Vector2i(-1,0),Vector2i(0,0), Vector2i(1,0)],
		[Vector2i(-1,1),Vector2i(0,1), Vector2i(1,1)],
		[Vector2i(-1,-1),Vector2i(-1,0), Vector2i(-1,1)],#COLUMNS
		[Vector2i(0,-1),Vector2i(0,0), Vector2i(0,1)],
		[Vector2i(1,-1),Vector2i(1,0), Vector2i(1,1)],
		[Vector2i(-1,1),Vector2i(0,0), Vector2i(1,-1)],#MAIN DIAGS
		[Vector2i(1,-1),Vector2i(0,0), Vector2i(-1,1)],
		[Vector2i(0,1),Vector2i(1,0), Vector2i(-1,-1)],#OFF DIAGS
		[Vector2i(1,1),Vector2i(-1,0), Vector2i(0,-1)],
		[Vector2i(-1,1),Vector2i(1,0), Vector2i(0,-1)],
		[Vector2i(-1,0),Vector2i(0,1), Vector2i(1,-1)]
	]
	for line in win_lines:
		if line[0] in box_array and line[1] in box_array and line[2] in box_array:
			highlight_win(line)
			playing = false
	

func highlight_win(line):
	for box in boxes:
		if box.index == line[0] or box.index == line[1] or box.index == line[2]:
			var box_style = box.get('theme_override_styles/panel')
			box_style.modulate_color = Color.RED
