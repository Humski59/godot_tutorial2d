extends CanvasLayer

signal use_move_vector

var move_vector = Vector2.ZERO
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
	var texture_center = $TouchScreenButton.position + Vector2(62.5, 62.5)
	#print($TouchScreenButton.position)
	#print(event_position)
	var normalized_event_position = (event_position - texture_center) / 62.5
	
	if normalized_event_position.x > 1:
		normalized_event_position.x = 1
	elif normalized_event_position.x < -1:
		normalized_event_position.x = -1
	
	if normalized_event_position.y > 1:
		normalized_event_position.y = 1
	elif normalized_event_position.y < -1:
		normalized_event_position.y = -1
	#print(normalized_event_position)
	
	return normalized_event_position

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	$Inner_circle.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
