extends CharacterBody2D

const SPEED = 300.0
@onready var occluder := $PointLight2D/LightOccluder2D
@onready var lightCone := $PointLight2D
@onready var health := $Health
@onready var sanity := $Sanity
var facing_direction: Vector2

const TARGET_Y_SCALE := 2.0
const DURATION := 1.0

var elapsed := 0.0
var start_scale_y := 1.0

#func _ready():
	#start_scale_y = occluder.scale.y

func _process(delta: float) -> void:
	if(health._current_health <= 0):
		get_tree().change_scene_to_file("res://scenes/deathScreen.tscn")
	
	
	
func _physics_process(delta: float) -> void:
	facing_direction = (get_global_mouse_position() - global_position).normalized()
	
	if sanity._current_sanity <= 0:
		if elapsed < DURATION:
			elapsed += delta
		else: 
			health.update_current_health(-1)
			elapsed = 0.0

	

	velocity = Vector2(0,0)
	lightCone.look_at(get_global_mouse_position())
	var direction := Input.get_axis("Left", "Right")
	var up_down := Input.get_axis("Up", "Down")
	if direction:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	elif up_down:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	
	move_and_slide()
