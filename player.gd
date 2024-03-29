extends Area2D

signal hit

@export var speed = 400
var screen_size
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity_t = Vector2.ZERO
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 1
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 1

	if velocity.length() > 0:
		velocity_t = velocity * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity_t * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func _on_mobile_control_use_move_vector(move_vector):
	#print(move_vector)
	velocity = move_vector
	#$AnimatedSprite2D.flip_h = move_vector.x < 0
	
