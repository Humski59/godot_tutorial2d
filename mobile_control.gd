extends CanvasLayer

signal use_move_vector

var outer_circle_radius


func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if event.is_pressed():
			$OuterCircle.visible = true
			$OuterCircle.position = event.position
			$InnerCircle.visible = true
		var move_vector = calculate_move_vector(event.position)
		emit_signal("use_move_vector", move_vector)
		$InnerCircle.position = move_vector * outer_circle_radius + $OuterCircle.position
			
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("use_move_vector", Vector2.ZERO)
			$OuterCircle.visible = false
			$InnerCircle.visible = false
			
			
func calculate_move_vector(event_position):
	var normalized_event_position = (event_position - $OuterCircle.position) / outer_circle_radius
	if normalized_event_position.length() > 1:
		normalized_event_position = normalized_event_position.normalized() 
	return normalized_event_position


func _ready():
	outer_circle_radius = $OuterCircle.get_rect().size[0] / 2 * $OuterCircle.scale
	$InnerCircle.visible = false
	$OuterCircle.visible = false
	

func _process(delta):
	pass
