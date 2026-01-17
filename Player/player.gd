extends CharacterBody2D

const MAX_SPEED = 150.0
const ACCELERATION = 600.0
const FRICTION = 1000.0

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir != Vector2.ZERO:
		animationTree.set("parameters/Idel/blend_position", input_dir)
		animationTree.set("parameters/Run/blend_position", input_dir)
		var target_velocity = input_dir * MAX_SPEED
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()

func _process(_delta):
	global_position = global_position.snapped(Vector2(1, 1))
