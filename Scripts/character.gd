extends CharacterBody2D

@export var health: HealthComponent

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

func _ready() -> void:
	health.died.connect(_on_died)

func _on_died() -> void: 
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")


var canDoubleJump = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		var canJump = false
		if is_on_floor():
			canJump = true
			canDoubleJump = true
		elif canDoubleJump:
			canJump = true
			canDoubleJump = false 
			
		if canJump:
			velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
