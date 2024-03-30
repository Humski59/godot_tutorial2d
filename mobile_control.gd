extends CanvasLayer

signal use_move_vector

var move_vector = Vector2.ZERO
var texture_center
var object_scale
var button_radius
var joystick_active = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			var move_vector = calculate_move_vector(event.position)
			var texture_center = $TouchScreenButton.position + Vector2(62.5, 62.5)
			print(move_vector)
			emit_signal("use_move_vector", move_vector)
			joystick_active = true
			$Inner_circle.position = move_vector * 62.5 + texture_center
			$Inner_circle.visible = true
		else:
			emit_signal("use_move_vector", Vector2.ZERO)
			
	if event is InputEventScreenTouch:
		if event.pressed == false:
			joystick_active = false
			$Inner_circle.visible = false
			
func calculate_move_vector(event_position):
	var normalized_event_position = (event_position - texture_center) / 62.5
	
	if normalized_event_position.length() > 1:
		normalized_event_position = normalized_event_position.normalized() 
	
	return normalized_event_position

func _ready():
	button_radius = $TouchScreenButton.shape.radius
	object_scale = $TouchScreenButton.scale
	texture_center = $TouchScreenButton.position + object_scale * button_radius
	$Inner_circle.visible = false

func _process(delta):
	pass
