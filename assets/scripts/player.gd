extends CharacterBody2D

const SPEED = 300.0
const NEAR_EXIT_DISTANCE = 500 # TODO 

const TARGET_Y_SCALE := 2.0
const DURATION := 1.0

var elapsed := 0.0
var start_scale_y := 1.0
var facing_direction: Vector2

const min_light_cone_scale = 0.5
const max_light_cone_scale = 1.5

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var lightCone := $PointLight2D
@onready var health := $Health
@onready var sanity := $Sanity
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var exit = get_tree().get_first_node_in_group("exit")
@onready var leaves_particles: GPUParticles2D = $leaves_particles
@onready var dust_particles: GPUParticles2D = $dust_particles
@onready var player_shadow: Sprite2D = $player_shadow

func _ready() -> void:
	leaves_particles.emitting = false
	dust_particles.emitting = false


func fade_out_audio(duration := 1.0) -> void:
	if not audio_stream_player_2d.playing:
		return

	var t := create_tween()
	t.tween_property(audio_stream_player_2d, "volume_db", -50.0, duration)
	t.finished.connect(
		func():
			audio_stream_player_2d.stop()
			audio_stream_player_2d.volume_db = 0.0 # reset for next play
	)


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
	
	var input_dir := Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down"))
	if input_dir:
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
			
		leaves_particles.emitting = true
		dust_particles.emitting = true
		velocity = input_dir * SPEED
		if input_dir.x < 0:
			sprite_2d.flip_h = true
			player_shadow.offset.x = 10
		elif input_dir.x > 0:
			sprite_2d.flip_h = false
			player_shadow.offset.x = -10
	else:
		if audio_stream_player_2d.playing:
			fade_out_audio()
		
		leaves_particles.emitting = false
		dust_particles.emitting = false
	
	move_and_slide()
	
	if(health._current_health <= 0):
		get_tree().change_scene_to_file("res://scenes/deathScreen.tscn")

func isNearExit() -> bool:
	return global_position.distance_to(exit.global_position) < NEAR_EXIT_DISTANCE

# if value is set to 1 the angle is 45°
func setConeScale(value:float) -> void:
	lightCone.scale.y = value
