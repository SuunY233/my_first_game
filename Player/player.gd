extends CharacterBody2D

const MAX_SPEED = 100.0
const ACCELERATION = 600.0
const FRICTION = 1000.0

var input_dir = Vector2.ZERO
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_dir != Vector2.ZERO:
		update_blend_position(input_dir)
		animationState.travel("Run")
		var target_velocity = input_dir * MAX_SPEED
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()

func _process(_delta):
	global_position = global_position.snapped(Vector2.ONE)

func update_blend_position(input_dir: Vector2) -> void:
	animationTree.set("parameters/Run/blend_position", input_dir)
	animationTree.set("parameters/Idle/blend_position", input_dir)
	animationTree.set("parameters/Attack/blend_position", input_dir)
	animationTree.set("parameters/Rool/blend_position", input_dir)
