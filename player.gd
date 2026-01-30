extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	velocity = Vector2(0,0)
	look_at(get_global_mouse_position())
	var direction := Input.get_axis("left", "right")
	var up_down := Input.get_axis("up", "down")
	if direction:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	elif up_down:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	
	move_and_slide()
