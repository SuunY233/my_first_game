extends CharacterBody2D

const MAX_SPEED = 150.0
const ACCELERATION = 600.0
const FRICTION = 1000.0

@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir != Vector2.ZERO:
		if input_dir.x > 0:
			animationPlayer.play("RunRight")
		else:
			animationPlayer.play("RunLeft")
		var target_velocity = input_dir * MAX_SPEED
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		animationPlayer.play("IdelRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
