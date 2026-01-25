extends CharacterBody2D

const SPEED = 120.0
const ROLL_SPEED = 125.0

var input_dir = Vector2.ZERO
var last_input_dir = Vector2.ZERO

@onready var animationTree: AnimationTree = $AnimationTree
@onready var playback = animationTree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"MoveState":
			process_move_state(delta)
		"AttackState":
			pass
		"RollState":
			process_roll_state(delta)

func process_move_state(delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_dir != Vector2.ZERO:
		last_input_dir = input_dir
		update_blend_position(input_dir)
	if Input.is_action_just_pressed("attack"):
		playback.travel("AttackState")
	if Input.is_action_just_pressed("roll"):
		playback.travel("RollState")
	velocity = input_dir * SPEED
	move_and_slide()

func process_roll_state(delta: float) -> void:
	velocity = last_input_dir.normalized() * ROLL_SPEED
	move_and_slide()

func update_blend_position(input_dir: Vector2) -> void:
	animationTree.set("parameters/StateMachine/MoveState/RunState/blend_position", input_dir)
	animationTree.set("parameters/StateMachine/MoveState/IdleState/blend_position", input_dir)
	animationTree.set("parameters/StateMachine/AttackState/blend_position", input_dir)
	animationTree.set("parameters/StateMachine/RollState/blend_position", input_dir)
