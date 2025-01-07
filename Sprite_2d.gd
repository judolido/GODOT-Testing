extends Sprite2D


var speed = 400
var angular_speed = PI

func _ready(): #also a special function, called when the scene is initiated
	var timer = get_node("Timer") # get_node is used to get a nodes methods, parameters, signals
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	visible = not visible
	
func _process(delta): #this is a special function that is called every frame, the delta is the time since tha last frame
	var direction = 0
	if Input.is_action_pressed("ui_left"):  #Input, just one of the two functions(classes to be precise) 
											#that checks if something is pressed
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1

	rotation += angular_speed * direction * delta
	
	var velocity = Vector2.ZERO
	var velocity2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
	if Input.is_action_pressed("ui_A"):
		velocity2 = Vector2(-400, 0).rotated(rotation)
	position += (velocity+velocity2) * delta # Position is a Vector!!!
	
	
	# var velocity = Vector2.UP.rotated(rotation)* speed
	# position += velocity * delta


func _on_button_pressed() -> void:
	set_process(not is_processing()) # Replace with function body.
